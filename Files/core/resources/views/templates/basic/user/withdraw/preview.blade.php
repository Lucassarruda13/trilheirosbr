@extends($activeTemplate.'layouts.master')
@section('content')
<div class="card custom--card">
    <div class="card-header">
        <h5 class="card-title">@lang('Withdraw Via') {{ $withdraw->method->name }}</h5>
    </div>
    <div class="card-body">
        <form action="{{route('user.withdraw.submit')}}" method="post" enctype="multipart/form-data">
            @csrf
            <div class="mb-2">
                @php
                    echo $withdraw->method->description;
                @endphp
            </div>
            <x-viser-form identifier="id" identifierValue="{{ $withdraw->method->form_id }}" />
            @if(auth()->user()->ts)
            <div class="form-group">
                <label>@lang('Google Authenticator Code')</label>
                <input type="text" name="authenticator_code" class="form-control form--control" required>
            </div>
            @endif
            <div class="form-group">
                <button type="submit" class="btn btn--base w-100">@lang('Submit')</button>
            </div>
        </form>
    </div>
</div>
@endsection
