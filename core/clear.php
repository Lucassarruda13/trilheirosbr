<?php
exec('php artisan config:clear');
exec('php artisan cache:clear');
exec('php artisan optimize');
echo "Feito!";
