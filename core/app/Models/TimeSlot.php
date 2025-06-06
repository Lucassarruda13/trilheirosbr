<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TimeSlot extends Model
{
    public function slots()
    {
        return $this->hasMany(Slot::class);
    }
}
