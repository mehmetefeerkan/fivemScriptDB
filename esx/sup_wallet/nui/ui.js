/*--------------------------------------------------------------------------

	sup_wallet - İtemli Cüzdan Scripti (actionmenu script edit)  

--------------------------------------------------------------------------*/

$( function() {

    init();

    var actionContainer = $( "#actionmenu" );

    window.addEventListener( 'message', function( event ) {
        var item = event.data;
        
        if ( item.showmenu ) {
            ResetMenu()
            actionContainer.show();
        }

        if ( item.hidemenu ) {
            actionContainer.hide(); 
        }
    } );

    document.onkeyup = function ( data ) {
        if ( data.which == 27 ) { // Escape key
            if ( actionContainer.is( ":visible" ) ) {
                sendData( "ButtonClick", "exit" )
            }
        }
    };
} )

function ResetMenu() {
    $( "div" ).each( function( i, obj ) {
        var element = $( this );

        if ( element.attr( "data-parent" ) ) {
            element.hide();
        } else {
            element.show();
        }
    } );
}

function init() {
    $( ".menuoption" ).each( function( i, obj ) {

        if ( $( this ).attr( "data-action" ) ) {
            $( this ).click( function() { 
                var data = $( this ).data( "action" ); 

                sendData( "ButtonClick", data ); 
            } )
        }

        if ( $( this ).attr( "data-sub" ) ) {
            var menu = $( this ).data( "sub" );
            var element = $( "#" + menu ); 

            $( this ).click( function() {
                element.show();
                $( this ).parent().hide();  
            } )

            $( this ).hover(
                function() {
                    $( this ).append( $( "<span> </span>" ) );
                }, function() {
                    $( this ).find( "span:last" ).remove();
                }
            );

            var backBtn = $( '<button/>', { text: 'Geri' } );
            
            backBtn.click( function() {
                element.hide();
                $( "#" + element.data( "parent" ) ).show();
            } );

            element.append( backBtn );
        }
    } );

    $( "#sup_wallet" ).children( "div" ).each( function( i, obj ) {
        var exitBtn = $( '<button/>', { text: 'Çıkış' } );
            
        exitBtn.click( function() {
            sendData( "ButtonClick", "exit" );
        } );

        $( this ).append( exitBtn );
    } );
}

function sendData( name, data ) {
    $.post( "http://sup_wallet/" + name, JSON.stringify( data ), function( datab ) {
        if ( datab != "ok" ) {
            console.log( datab );
        }            
    } );
}
