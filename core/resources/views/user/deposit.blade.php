@extends('layouts.app') {{-- ou o layout que você usar --}}

@section('content')
    <h4>Escaneie com o celular:</h4>

    @if($qr_code_base64)
        <img src="data:image/png;base64,{{ $qr_code_base64 }}" width="250" />
        <h5>Ou copie e cole:</h5>
        <pre>{{ $qr_code }}</pre>
    @else
        <p>Erro ao gerar o QR Code. Tente novamente.</p>
    @endif
@endsection
