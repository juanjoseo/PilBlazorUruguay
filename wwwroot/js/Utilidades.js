function saveAsFile(filename, bytesBase64) {
    var link = document.createElement('a');
    link.download = filename;
    link.href = "data:application/octet-stream;base64," + bytesBase64;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function CustomConfirm(titulo, mensaje, tipo, ptoast) { //ptoast 1 solo info con timer, 2 ayuda, 3 confimar
    if (ptoast == 1) {
        Swal.fire({
            toast:true,
            position: 'top-end',
            icon: tipo,
            title: mensaje,
            showConfirmButton: false,
            timer: 3500,
            timerProgressBar: true,
            animation: true
        })
        return true;
    }
    if (ptoast == 2) {
        Swal.fire({
            icon: 'question',
            title: "Ayuda",
            html: mensaje,
            width: "850px",

            animation: true
        })
        return true;
    }
    else {
        return new Promise((resolve) => {
            Swal.fire({
                title: titulo,
                text: mensaje,
                icon: tipo,
                showCancelButton: true,
                showConfirmButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Confirmar',
                cancelButtonText: 'Cancelar'            
            }).then((result) => {
                if (result.isConfirmed) {
                    if (result.value) {
                        resolve(true);
                    } else {
                        resolve(false);
                    }                
                }
            })
        });
    }
}