<?php

use Illuminate\Support\Facades\Route;
use App\Models\Order;
use App\Http\Controllers\TicketController;




Route::get('/testar-order-update', function () {
    // Troque o número abaixo para o ID de uma order REAL no seu banco
    $order = Order::find(26);

    if (!$order) {
        return "Ordem não encontrada.";
    }

    // Primeiro definimos como UNPAID (só por segurança)
    $order->payment_status = 0;
    $order->save();

    // Agora mudamos para PAID para acionar o evento de updated()
    $order->payment_status = 1;
    $order->save();

    return "Teste de update executado com sucesso.";
});




Route::get('/clear', function () {
    \Illuminate\Support\Facades\Artisan::call('optimize:clear');
});


Route::get('cron', 'CronController@cron')->name('cron');

// User Support Ticket
Route::controller('TicketController')->prefix('ticket')->name('ticket.')->group(function () {
    Route::get('/', 'supportTicket')->name('index');
    Route::get('new', 'openSupportTicket')->name('open');
    Route::post('create', 'storeSupportTicket')->name('store');
    Route::get('view/{ticket}', 'viewTicket')->name('view');
    Route::post('reply/{id}', 'replyTicket')->name('reply');
    Route::post('close/{id}', 'closeTicket')->name('close');
    Route::get('download/{attachment_id}', 'ticketDownload')->name('download');
});

Route::get('app/deposit/confirm/{hash}', 'Gateway\PaymentController@appDepositConfirm')->name('deposit.app.confirm');

Route::controller('SiteController')->group(function () {
    Route::get('/events/{slug?}', 'allEvents')->name('event.index');
    Route::get('/event/{slug}', 'eventDetails')->name('event.details');
    Route::get('/organizers', 'allOrganizers')->name('organizer.index');
    Route::get('/organizer/{slug}', 'organizerDetails')->name('organizer.details');
    Route::get('ticket-download/{ticketId}', 'downloadTicket')->name('event.ticket.download');


    Route::post('/subscribe', 'addSubscriber')->name('subscribe');
    Route::get('/contact', 'contact')->name('contact');
    Route::post('/contact', 'contactSubmit');
    Route::get('/change/{lang?}', 'changeLanguage')->name('lang');

    Route::get('cookie-policy', 'cookiePolicy')->name('cookie.policy');

    Route::get('/cookie/accept', 'cookieAccept')->name('cookie.accept');

    Route::get('blogs', 'blogs')->name('blogs');

    Route::get('blog/{slug}', 'blogDetails')->name('blog.details');

    Route::get('policy/{slug}', 'policyPages')->name('policy.pages');

    Route::get('placeholder-image/{size}', 'placeholderImage')->withoutMiddleware('maintenance')->name('placeholder.image');
    Route::get('maintenance-mode', 'maintenance')->withoutMiddleware('maintenance')->name('maintenance');

    Route::get('/{slug}', 'pages')->name('pages');
    Route::get('/', 'index')->name('home');
});


Route::post('/scanner/validate', [TicketController::class, 'validateTicket'])->name('scanner.validate');



Route::get('/user/event/ticket/scanner', function () {
    return view('scanner');
})->name('user.event.ticket.scanner')->middleware('auth:organizer'); // para proteger o acesso


use App\Http\Controllers\Gateway\MercadoPago\ProcessController;

Route::post('/deposito/generate-pix', [ProcessController::class, 'ajaxGeneratePix'])->name('deposito.generatePix');

Route::get('/deposito/check-status/{trx}', [ProcessController::class, 'checkStatusPix'])->name('deposito.checkStatusPix');



Route::get('/deposit/success', [ProcessController::class, 'depositSuccess'])->name('deposit.success');
Route::get('/deposit/failed', [ProcessController::class, 'depositFailed'])->name('deposit.failed');
Route::get('/deposit/pending', [ProcessController::class, 'depositPending'])->name('deposit.pending');


use App\Http\Controllers\Gateway\Mercadopago\NotificationController;

Route::post('/mercadopago/notification', [NotificationController::class, 'handle'])->name('mercadopago.notification');



