@extends('templates.basic.organizer.layouts.app')

@php
    $pageTitle = 'Scanner de Ingressos';
@endphp

<meta name="csrf-token" content="{{ csrf_token() }}">

@section('panel')
<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

    html, body {
        height: 100%;
        margin: 0;
        background: #f9fafb;
        font-family: 'Roboto', sans-serif;
    }

    .page-wrapper {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 1rem;
        box-sizing: border-box;
    }

    .scanner-container {
        max-width: 480px;
        width: 100%;
        background: #ffffff;
        border-radius: 1rem;
        padding: 1.5rem 2rem;
        box-shadow: 0 4px 12px rgb(55 65 81 / 0.1);
        text-align: center;
        color: #374151;
    }

    h3.title-with-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        color: #3B82F6;
        font-weight: 800;
        margin-bottom: 1rem;
    }

    p.instructions {
        font-size: 1rem;
        color: #6B7280;
        margin-bottom: 1.5rem;
    }

    button#btn-reset {
        background-color: #3B82F6;
        color: white;
        border: none;
        padding: 0.7rem 2rem;
        font-size: 1.1rem;
        font-weight: 600;
        border-radius: 1rem;
        box-shadow: 0 4px 8px rgb(59 130 246 / 0.4);
        cursor: pointer;
        transition: opacity 0.2s ease;
        user-select: none;
        margin-top: 1rem;
    }

    button#btn-reset:hover {
        opacity: 0.85;
    }

    /* Modal */
    .modal-bg {
        position: fixed;
        inset: 0;
        background-color: rgba(0,0,0,0.4);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    .modal-content {
        background: white;
        padding: 2rem 2.5rem;
        border-radius: 1rem;
        max-width: 420px;
        text-align: center;
        box-shadow: 0 8px 16px rgba(0,0,0,0.15);
    }

    .modal-content h3 {
        font-size: 1.5rem;
        margin-bottom: 1rem;
        color: #1E3A8A;
        font-weight: 700;
    }

    .modal-content p {
        font-size: 1rem;
        margin-bottom: 1.5rem;
        color: #374151;
    }

    .modal-btn {
        background-color: #3B82F6;
        color: white;
        border: none;
        padding: 0.7rem 2rem;
        border-radius: 1rem;
        font-weight: 700;
        font-size: 1rem;
        cursor: pointer;
        box-shadow: 0 4px 8px rgba(59,130,246,0.4);
        transition: background-color 0.3s ease;
        user-select: none;
    }

    .modal-btn:hover {
        background-color: #2563EB;
    }

    #qr-reader {
        width: 100%;
        height: 350px;
        border-radius: 1rem;
        background: #F3F4F6;
        overflow: hidden;
    }

   /* Botão Voltar fora do container, alinhado esquerda com borda cinza clara */
    .btn-back {
        display: inline-block;
        margin: 1rem 0;
        padding: 0.3rem 0.8rem;
        font-size: 0.9rem;
        font-weight: 500;
        color: #1E3A8A;
        border: 1px solid #CBD5E1; /* cinza fraquinho */
        border-radius: 0.5rem;
        background-color: transparent;
        text-decoration: none;
        transition: background-color 0.2s ease, color 0.2s ease;
    }

    .btn-back:hover {
        background-color: #E0E7FF; /* leve azul claro */
        color: #1E40AF;
    }


    /* Título principal h2 centralizado */
    h2.scanner-title {
        color: #1E3A8A;
        font-weight: 700;
        font-size: 2rem;
        text-align: center;
        margin-bottom: 1rem;
        font-family: 'Roboto', sans-serif;
    }
    /* SVG pulsante em azul cinza fraco para azul escuro */
    .pulsing-svg {
      color: #7f9cf5; /* azul cinza claro inicial */
      animation: pulse-color 2.5s ease-in-out infinite;
      display: block;
      margin: 1rem auto 2rem;
    }

    @keyframes pulse-color {
      0%, 100% {
        color: #7f9cf5; /* azul cinza claro */
      }
      50% {
        color: #2752cc; /* azul escuro */
      }
    }
</style>



<div class="page-wrapper" role="main" aria-label="Scanner de ingressos">
<!-- Botão Voltar fora do container, alinhado à esquerda -->
<a href="/organizer/dashboard" class="btn-back" aria-label="Voltar para o dashboard">
    ← Voltar
</a>

    <h2 class="scanner-title">Scanner de Ingressos</h2>
    
    
    <div class="scanner-container">
 

        <h3 class="title-with-icon" aria-live="polite">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#3B82F6" viewBox="0 0 24 24" aria-hidden="true" role="img" focusable="false">
                <path d="M20 5h-3.586l-1.707-1.707A.996.996 0 0014 3H10a.996.996 0 00-.707.293L7.586 5H4c-1.103 0-2 .897-2 2v10c0 1.103.897 2 2 2h16c1.103 0 2-.897 2-2V7c0-1.103-.897-2-2-2zm0 12H4V7h4.586l1.707-1.707h2.414L15.414 7H20v10zM12 9a5 5 0 100 10 5 5 0 000-10zm0 8a3 3 0 110-6 3 3 0 010 6z"/>
            </svg>
            Validação Ingressos
        </h3>

        <p class="instructions">
            Escaneie o QR code do ingresso<br>para validar a entrada do participante.
        </p>

        <svg class="pulsing-svg" width="100" height="100" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" focusable="false">
            <path d="M22 11.5V14.6C22 16.8402 22 17.9603 21.564 18.816C21.1805 19.5686 20.5686 20.1805 19.816 20.564C18.9603 21 17.8402 21 15.6 21H8.4C6.15979 21 5.03969 21 4.18404 20.564C3.43139 20.1805 2.81947 19.5686 2.43597 18.816C2 17.9603 2 16.8402 2 14.6V9.4C2 7.15979 2 6.03969 2.43597 5.18404C2.81947 4.43139 3.43139 3.81947 4.18404 3.43597C5.03969 3 6.15979 3 8.4 3H12.5M19 8V2M16 5H22M16 12C16 14.2091 14.2091 16 12 16C9.79086 16 8 14.2091 8 12C8 9.79086 9.79086 8 12 8C14.2091 8 16 9.79086 16 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>


        <p class="instructions">
Clique no botão abaixo para iniciar o scanner de QR code e validar os ingressos do evento

        </p>


        <button id="btn-reset" aria-label="Iniciar scanner">Iniciar Scanner</button>
    </div>
    
    
    
</div>

<!-- Modal Scanner -->
<div class="modal-bg" id="scanner-modal" role="dialog" aria-modal="true" aria-labelledby="scanner-modal-title" aria-describedby="scanner-modal-desc">
    <div class="modal-content">
        <h3 id="scanner-modal-title">Escaneie o QR Code</h3>
        <div id="qr-reader" aria-live="polite" aria-atomic="true"></div>
        <p id="qr-result">Aguardando leitura...</p>
        <button class="modal-btn" id="close-scanner">Fechar Scanner</button>
    </div>
</div>

<!-- Modal Resultado -->
<div class="modal-bg" id="result-modal" role="dialog" aria-modal="true" aria-labelledby="result-modal-title" aria-describedby="result-modal-desc">
    <div class="modal-content">
        <h3 id="result-modal-title">Resultado da Validação</h3>
        <p id="result-modal-desc"></p>
        <button class="modal-btn" id="close-result">Fechar</button>
    </div>
</div>

<script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const btnReset = document.getElementById('btn-reset');
        const scannerModal = document.getElementById('scanner-modal');
        const resultModal = document.getElementById('result-modal');
        const closeScannerBtn = document.getElementById('close-scanner');
        const closeResultBtn = document.getElementById('close-result');
        const qrResult = document.getElementById('qr-result');
        const resultModalDesc = document.getElementById('result-modal-desc');
        let html5QrCode;
        let scanning = false;

        function showModal(modal) {
            modal.style.display = 'flex';
            modal.setAttribute('aria-hidden', 'false');
        }

        function hideModal(modal) {
            modal.style.display = 'none';
            modal.setAttribute('aria-hidden', 'true');
        }

        btnReset.addEventListener('click', function () {
            if (scanning) return; // evita múltiplos cliques

            showModal(scannerModal);

            html5QrCode = new Html5Qrcode("qr-reader");

            Html5Qrcode.getCameras().then(cameras => {
                if (cameras && cameras.length) {
                    const cameraId = cameras[1].id;

                    html5QrCode.start(
                        cameraId,
                        {
                            fps: 10,
                            qrbox: { width: 350, height: 350 }
                        },
                        qrCodeMessage => {
                            qrResult.textContent = `QR Code detectado: ${qrCodeMessage}`;

                            // Exemplo de requisição para validar o ingresso via API
                            fetch('/api/validate-ticket', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json',
                                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                                },
                                body: JSON.stringify({ code: qrCodeMessage })
                            })
                            .then(res => res.json())
                            .then(data => {
                                // Parar scanner
                                html5QrCode.stop().then(() => {
                                    scanning = false;
                                    hideModal(scannerModal);
                                });

                                // Mostrar resultado na modal
                                if(data.valid) {
                                    resultModalDesc.textContent = `Ingresso válido para: ${data.name}`;
                                } else {
                                    resultModalDesc.textContent = `Ingresso inválido ou já utilizado.`;
                                }
                                showModal(resultModal);
                            })
                            .catch(() => {
                                html5QrCode.stop().then(() => {
                                    scanning = false;
                                    hideModal(scannerModal);
                                });
                                resultModalDesc.textContent = 'Erro ao validar ingresso. Tente novamente.';
                                showModal(resultModal);
                            });
                        },
                        errorMessage => {
                            // Pode usar para mostrar mensagens de erro no console ou UI se desejar
                            // console.log('QR Code scan error:', errorMessage);
                        }
                    ).then(() => {
                        scanning = true;
                    }).catch(err => {
                        alert('Erro ao iniciar câmera: ' + err);
                        hideModal(scannerModal);
                    });
                } else {
                    alert('Nenhuma câmera encontrada.');
                    hideModal(scannerModal);
                }
            }).catch(err => {
                alert('Erro ao acessar câmeras: ' + err);
                hideModal(scannerModal);
            });
        });

        closeScannerBtn.addEventListener('click', function () {
            if (html5QrCode && scanning) {
                html5QrCode.stop().then(() => {
                    scanning = false;
                    hideModal(scannerModal);
                });
            } else {
                hideModal(scannerModal);
            }
        });

        closeResultBtn.addEventListener('click', function () {
            hideModal(resultModal);
            qrResult.textContent = 'Aguardando leitura...';
        });

        // Fecha modais com Esc
        document.addEventListener('keydown', function(event) {
            if(event.key === 'Escape') {
                if(scannerModal.style.display === 'flex') {
                    closeScannerBtn.click();
                }
                if(resultModal.style.display === 'flex') {
                    closeResultBtn.click();
                }
            }
        });
    });
</script>
@endsection
