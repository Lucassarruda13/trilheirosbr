<?php

namespace App\Http\Controllers\Gateway\Mercadopago;

use App\Http\Controllers\Controller;
use App\Models\Deposit;

class ProcessController extends Controller


{
    
    
    
    public static function process($deposit)
    {
        $accessToken = env('MERCADO_PAGO_ACCESS_TOKEN');

        if (!$accessToken) {
            return json_encode([
                'error' => true,
                'message' => 'Token de acesso Mercado Pago não configurado.'
            ]);
        }

        $paymentData = [
            "transaction_amount" => (float) $deposit->amount,
            "description" => "Depósito #" . $deposit->trx,
            "payment_method_id" => "pix",
            "payer" => [
                "email" => $deposit->user->email ?? "email@example.com",
                "first_name" => $deposit->user->name ?? "Cliente",
            ],
            "external_reference" => $deposit->trx,
            "notification_url" => route('mercadopago.notification') // Se quiser webhook para notificação de pagamento
        ];

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, "https://api.mercadopago.com/v1/payments");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($paymentData));
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    "Content-Type: application/json",
    "Authorization: Bearer $accessToken",
    "X-Idempotency-Key: " . uniqid('mp_', true)
]);


        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $curlError = curl_error($ch);
        curl_close($ch);

        if ($curlError) {
            
            
            return json_encode([
                'error' => true,
                'message' => 'Erro cURL: ' . $curlError
            ]);
        }

        if ($httpCode !== 201) {
            return json_encode([
                'error' => true,
                'message' => "Erro na API Mercado Pago. HTTP Code: $httpCode. Resposta: $response"
            ]);
        }

        $responseData = json_decode($response);

        // O QR code e payload ficam em:
        // $responseData->point_of_interaction->transaction_data->qr_code
        // $responseData->point_of_interaction->transaction_data->qr_code_base64

        if (isset($responseData->point_of_interaction->transaction_data->qr_code)) {
            return json_encode([
                'success' => true,
                'qr_code' => $responseData->point_of_interaction->transaction_data->qr_code,
                'qr_code_base64' => $responseData->point_of_interaction->transaction_data->qr_code_base64,
                'payment_id' => $responseData->id
            ]);
        }

        return json_encode([
            'error' => true,
            'message' => 'Erro ao gerar pagamento PIX. Resposta: ' . $response
        ]);
    }


}


