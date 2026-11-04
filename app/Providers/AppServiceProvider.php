<?php

namespace App\Providers;

use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;
use Illuminate\Database\Events\ConnectionEstablished;
use Illuminate\Database\Events\QueryExecuted;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;
use PDO;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);

        Event::listen(ConnectionEstablished::class, function (
            ConnectionEstablished $event
        ): void {
            $trace = collect(
                debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 30)
            )
                ->filter(function (array $frame): bool {
                    return isset($frame['file'])
                        && str_contains($frame['file'], base_path('app'));
                })
                ->map(function (array $frame): array {
                    return [
                        'file' => $frame['file'] ?? null,
                        'line' => $frame['line'] ?? null,
                        'class' => $frame['class'] ?? null,
                        'type' => $frame['type'] ?? null,
                        'function' => $frame['function'] ?? null,
                    ];
                })
                ->values()
                ->all();

            Log::channel('daily')->warning(
                'Conexión PDO establecida',
                [
                    'connection' => $event->connectionName,
                    'pid' => getmypid(),
                    'route' => app()->runningInConsole()
                        ? 'console'
                        : request()->method() . ' ' . request()->path(),
                    'trace' => $trace,
                ]
            );
        });
    }
}
