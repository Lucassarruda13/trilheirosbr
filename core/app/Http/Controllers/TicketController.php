<?php

namespace App\Http\Controllers;

use App\Traits\SupportTicketManager;
use Illuminate\Http\Request;
use App\Models\Order;  // Certifique-se que o model Order está aqui, ajuste se necessário

class TicketController extends Controller
{
    use SupportTicketManager;

    public function __construct()
    {
        parent::__construct();
        $this->layout = 'frontend';
        $this->redirectLink = 'ticket.view';
        $this->userType     = 'user';
        $this->column       = 'user_id';
        $this->user = auth()->user();
        if ($this->user) {
            $this->layout = 'master';
        }
    }

    // Novo método para validar ingresso via hash
    public function validateTicket(Request $request)
    {
        $hash = $request->input('hash');

        if (!$hash) {
            return response()->json(['success' => false, 'message' => 'Hash não fornecido.'], 400);
        }

        $order = Order::where('qr_code_data', $hash)->first();

        if (!$order) {
            return response()->json(['success' => false, 'message' => 'Ingresso não encontrado.'], 404);
        }

        // Verifica se pagamento está confirmado (ajuste o valor conforme seu sistema)
        if ($order->payment_status != 1) {
            return response()->json(['success' => false, 'message' => 'Ingresso não pago.'], 403);
        }

        // Verifica se ingresso já foi validado
        if ($order->ticket_validated == 1) {
            return response()->json(['success' => false, 'message' => 'Ingresso já validado.'], 409);
        }

        // Atualiza para validado
        $order->ticket_validated = 1;
        $order->save();

        return response()->json(['success' => true, 'message' => 'Ingresso validado com sucesso!']);
    }
}
