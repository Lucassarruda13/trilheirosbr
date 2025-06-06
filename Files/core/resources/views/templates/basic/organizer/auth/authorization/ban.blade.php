@extends($activeTemplate . 'layouts.frontend')
@section('content')
    <div class="container py-70">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card custom--card">
                    <div class="card-body">
                        <h3 class="text-center text--danger">@lang('You are banned')</h3>
                        <p class="fw-bold mb-1">@lang('Reason'):</p>
                        <p>{{ $organizer->ban_reason }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
