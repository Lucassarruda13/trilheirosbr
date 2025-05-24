<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Order; // ajuste o caminho conforme seu model Order

class MercadoPagoController extends Controller
{
    public function gerarPixMP($orderId, $valor, $descricao, $emailPayer)
    {
        $accessToken = env('MP_ACCESS_TOKEN');

        $response = Http::withToken($accessToken)->post('https://api.mercadopago.com/v1/payments', [
            'transaction_amount' => floatval($valor),
            'description' => $descricao,
            'payment_method_id' => 'pix',
            'external_reference' => 'order_'.$orderId,
            'notification_url' => url('/webhook/mp'),
            'payer' => [
                'email' => $emailPayer
            ]
        ]);

        return $response->json();
    }

    // Controller para mostrar a view do depósito com o QR code
    public function showDeposit($orderId)
    {
        $order = Order::findOrFail($orderId);
        $userEmail = auth()->user()->email;

        $data = $this->gerarPixMP($order->id, $order->amount, 'Depósito para pedido #' . $order->id, $userEmail);

        if (isset($data['point_of_interaction']['transaction_data']['qr_code_base64'])) {
            $qr_code_base64 = $data['point_of_interaction']['transaction_data']['qr_code_base64'];
            $qr_code = $data['point_of_interaction']['transaction_data']['qr_code'];
        } else {
            $qr_code_base64 = null;
            $qr_code = null;
        }

        return view('user.deposit', compact('order', 'qr_code_base64', 'qr_code'));
    }

    // Webhook que recebe notificação do Mercado Pago
    public function webhook(Request $request)
    {
        $data = $request->all();

        if (isset($data['type']) && $data['type'] === 'payment') {
            $paymentId = $data['data']['id'];

            $payment = Http::withToken(env('MP_ACCESS_TOKEN'))
                ->get("https://api.mercadopago.com/v1/payments/{$paymentId}")
                ->json();

            if (isset($payment['status']) && $payment['status'] === 'approved') {
                $external = $payment['external_reference']; // ex: order_43
                $orderId = str_replace('order_', '', $external);
                $order = Order::find($orderId);

                if ($order && $order->payment_status != 1) {
                    $order->payment_status = 1; // pago
                    $order->save();
                }
            }
        }

        return response()->json(['status' => 'ok']);
    }
}
