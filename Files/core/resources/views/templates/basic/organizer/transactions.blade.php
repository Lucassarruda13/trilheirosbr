@extends($activeTemplate . 'organizer.layouts.master')
@section('content')
    <div class="show-filter mb-3 text-end">
        <button type="button" class="btn btn--base showFilterBtn btn--sm"><i class="las la-sliders-h"></i></button>
    </div>
    <div class="card responsive-filter-card mb-4 trx-form">
        <div class="card-body">
            <form>
                <div class="d-flex flex-wrap gap-4">
                    <div class="flex-grow-1">
                        <label>@lang('Transaction Number')</label>
                        <input type="search" name="search" value="{{ request()->search }}"
                            class="form-control form--control">
                    </div>
                    <div class="flex-grow-1">
                        <label>@lang('Type')</label>
                        <select name="trx_type" class="form-select form--control custom-select">
                            <option value="">@lang('All')</option>
                            <option value="+" @selected(request()->trx_type == '+')>@lang('Plus')</option>
                            <option value="-" @selected(request()->trx_type == '-')>@lang('Minus')</option>
                        </select>
                    </div>
                    <div class="flex-grow-1">
                        <label>@lang('Remark')</label>
                        <select class="form-select form--control custom-select" name="remark">
                            <option value="">@lang('Any')</option>
                            @foreach ($remarks as $remark)
                                <option value="{{ $remark->remark }}" @selected(request()->remark == $remark->remark)>
                                    {{ __(keyToTitle($remark->remark)) }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="flex-grow-1 align-self-end">
                        <button class="btn btn-primary w-100"><i class="las la-filter"></i> @lang('Filter')</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="card custom--card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table custom--table table--responsive--md">
                    <thead>
                        <tr>
                            <th>@lang('Trx')</th>
                            <th>@lang('Transacted')</th>
                            <th>@lang('Amount')</th>
                            <th>@lang('Post Balance')</th>
                            <th>@lang('Detail')</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($transactions as $trx)
                            <tr>
                                <td>
                                    <strong>{{ $trx->trx }}</strong>
                                </td>

                                <td>
                                    {{ showDateTime($trx->created_at) }}<br>{{ diffForHumans($trx->created_at) }}
                                </td>

                                <td class="budget">
                                    <span
                                        class="fw-bold @if ($trx->trx_type == '+') text--success @else text--danger @endif">
                                        {{ $trx->trx_type }} {{ showAmount($trx->amount) }} {{ gs('cur_text') }}
                                    </span>
                                </td>

                                <td class="budget">
                                    {{ showAmount($trx->post_balance) }} {{ __(gs('cur_text')) }}
                                </td>

                                <td>{{ __($trx->details) }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td class="text-muted text-center" colspan="100%">{{ __($emptyMessage) }}</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if ($transactions->hasPages())
            <div class="card-footer">
                {{ paginateLinks($transactions) }}
            </div>
        @endif
    </div>
@endsection
