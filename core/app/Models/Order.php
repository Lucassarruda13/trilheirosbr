<?php

namespace App\Models;

use App\Constants\Status;
use App\Traits\GlobalStatus;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;



class Order extends Model
{
    use GlobalStatus;

    protected $casts = [
        'details' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function event()
    {
        return $this->belongsTo(Event::class, 'event_id');
    }

    public function deposits()
    {
        return $this->hasMany(Deposit::class, 'order_id')->latest('id')->where('status', Status::YES);
    }

    public function statusBadge(): Attribute
    {
        return new Attribute(function () {
            $html = '';
            if ($this->status == Status::PAYMENT_PENDING) {
                $html = '<span class="badge badge--warning">' . trans('Payment Pending') . '</span>';
            } elseif ($this->status == Status::ORDER_COMPLETED) {
                $html = '<span><span class="badge badge--success">' . trans('Active') . '</span></span>';
            } elseif ($this->status == Status::ORDER_CANCELLED) {
                $html = '<span><span class="badge badge--danger">' . trans('Cancelled') . '</span></span>';
            }
            return $html;
        });
    }

    public function paymentData(): Attribute
    {
        return new Attribute(function () {
            $html = '';
            if ($this->payment_status == STATUS::PAID && $this->status == Status::ORDER_CANCELLED) {
                $html = '<span class="badge badge--success">' . trans('Refunded') . '</span>';
            } elseif ($this->payment_status == Status::PAID) {
                $html = '<span class="badge badge--success">' . trans('Paid') . '</span>';
            } else {
                $html = '<span class="badge badge--warning">' . trans('Pending') . '</span>';
            }
            return $html;
        });
    }



protected static function booted()
{
    Log::info('Booted loaded'); // <- Aqui você vê se o boot foi executado

    static::updated(function ($order) {
        Log::info("Cheguei aqui", ['file' => __FILE__, 'line' => __LINE__]);

        Log::info('Comparando valores', [
            'Status::PAID' => Status::PAID,
            'Order payment_status' => $order->payment_status,
        ]);

        Log::info("Order updated event triggered", [
            'order_id' => $order->id,
            'payment_status_dirty' => $order->isDirty('payment_status'),
            'payment_status' => $order->payment_status,
            'qr_code_data_empty' => empty($order->qr_code_data),
        ]);

        if (
            $order->isDirty('payment_status') &&
            $order->payment_status == Status::PAID &&
            empty($order->qr_code_data)
        ) {
            Log::info("Conditions met for QR generation", ['order_id' => $order->id]);
            $order->generateAndSaveQrCode();
        }
    });
}



public function generateAndSaveQrCode()
{
    try {
        Log::info("Starting QR code generation for order", ['order_id' => $this->id]);

        $data = [
            'order_id' => $this->id,
            'user_id' => $this->user_id,
            'event_id' => $this->event_id,
            'timestamp' => now()->timestamp
        ];

        $payload = json_encode($data);

        Log::info("Payload generated", ['payload' => $payload]);

        $secret = env('QR_SECRET_KEY');

        if (empty($secret)) {
            Log::error("QR_SECRET_KEY is not set in .env");
            return;
        }

        $signature = hash_hmac('sha256', $payload, $secret);

        Log::info("Signature generated", ['signature' => $signature]);

        $finalData = base64_encode($payload) . '.' . $signature;

        $qrCodeImage = \SimpleSoftwareIO\QrCode\Facades\QrCode::format('png')->size(300)->generate($finalData);

        $filePath = 'qrcodes/order_' . $this->id . '.png';

        $saved = \Storage::disk('public')->put($filePath, $qrCodeImage);

        Log::info("QR code saved", ['file_path' => $filePath, 'saved' => $saved]);

        if (!$saved) {
            Log::error("Failed to save QR code image", ['order_id' => $this->id]);
            return;
        }

        $this->qr_code_data = $finalData;
        $this->qr_code_path = $filePath;

        $savedModel = $this->save();

        Log::info("Order model saved with QR code data", ['saved' => $savedModel]);

    } catch (\Exception $e) {
        Log::error("Error generating QR code for order", [
            'order_id' => $this->id,
            'error' => $e->getMessage(),
        ]);
    }
}









    public function scopeUserOrders($query)
    {
        return $query->where('user_id', auth()->user()->id)->orderBy('id', 'DESC');
    }

    public function scopeOrganizerTicketsSold($query, $organizerId = 0)
    {
        if (!$organizerId) {
            $organizerId = authOrganizerId();
        }

        $query->whereHas('event', function ($query) use ($organizerId) {
            $query->where('organizer_id', $organizerId);
        });
    }

    public function scopeCompleted($query)
    {
        return $query->where('status', Status::ORDER_COMPLETED)->orderBy('id', 'DESC');
    }
    public function scopePaymentPending($query)
    {
        return $query->where('status', Status::ORDER_PAYMENT_PENDING)->orderBy('id', 'DESC');
    }
    public function scopeCancelled($query)
    {
        return $query->where('status', Status::ORDER_CANCELLED)->orderBy('id', 'DESC');
    }

    public function scopePaid($query)
    {
        return $query->where('payment_status', Status::PAID)->orderBy('id', 'DESC');
    }

    public function scopeUnpaid($query)
    {
        return $query->where('payment_status', Status::UNPAID)->orderBy('id', 'DESC');
    }

    public function scopeRefunded($query)
    {
        return $query->where('payment_status', Status::PAID)->where('status', Status::ORDER_CANCELLED)->orderBy('id', 'DESC');
    }

    public function canCancel($hours)
    {
        $eventStartDateTime = $this->event->start_date . ' ' . $this->event->start_time;
        $eventStartTime = Carbon::parse($eventStartDateTime);
        $currentTime = Carbon::now();

        // Check if the event starts within 4 hours from now
        return $currentTime->diffInHours($eventStartTime, false) > $hours;
    }
}
