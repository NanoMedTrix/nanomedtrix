jQuery(function( $ ) {
	$( '.destroy_banner_style' ).live( 'click', function( e ) {
		e.preventDefault();

		$( this ).parent().remove();
	});

	$( '.destroy_new_banner_styles' ).live( 'click', function( e ) {
		e.preventDefault();
	
		$( this ).closest( '.new_banner_styles' ).remove();
	});

	// Handle adding new styles
	var styles_hash_index = 1;

	$( '.add_new_banner_style' ).live( 'click', function( e ) {
		e.preventDefault();
		
		$( '#new-banner-styles' ).append( generate_html_for_hash( 'new_banner_styles', styles_hash_index ) );
	});

	// Generates html for new paperclip styles form fields
	generate_html_for_hash = function( hash_name, index ) {
		var html  = '<div class="' + hash_name + ' row"><div class="field">';
				html += '<div class="five columns">';
				html += '<label for="' + hash_name + '_' + index + '_name">';
				html += Spree.translations.name + '</label>';
				html += '<input id="' + hash_name + '_' + index + '_name" name="' + hash_name + '[' + index + '][name]" type="text" class="fullwidth"><br>';
				html += '</div><div class="five columns">'
				html += '<label for="' + hash_name + '_' + index + '_value">';
				html += Spree.translations.value + '</label>';
				html += '<input id="' + hash_name + '_' + index + '_value" name="' + hash_name + '[' + index + '][value]" type="text" class="fullwidth">';
				html += '</div><div class="two columns">'
				html += '<a href="#" title="' + Spree.translations.destroy + '" class="destroy_' + hash_name + ' with-tip button" style="margin-top: 19px;"><i class="icon-trash"></i> &nbsp; ' + Spree.translations.destroy + '</a>';
				html += '</div></div></div>';

		index += 1;
				
		return html;
	};
});


$( document ).ready(function() {
	// Fix sortable helper
  var fixHelper = function( e, ui ) {
    ui.children().each(function() {
      $( this ).width( $( this ).width() );
    });

    return ui;
  }
  
	$( 'table.sort' ).ready(function() {
		var td_count = $( this ).find( 'tbody tr:first-child td' ).length;

		$( 'table.sort tbody' ).sortable({
			handle:      '.sort-handle',
			helper:      fixHelper,
			placeholder: 'ui-sortable-placeholder',
			update: function( event, ui ) {
				$( '#progress' ).show();

				positions = {};

				$.each( $( 'table.sort tbody tr' ), function( position, obj ) {
					reg   = /spree_(\w+_?)+_(\d+)/;
					parts = reg.exec( $( obj ).attr( 'id' ) );

					if ( parts ) { positions[ 'positions[' + parts[ 2 ] + ']' ] = position; }
				});

				$.ajax({
					type:     'POST',
					dataType: 'script',
					url: $( ui.item ).closest( 'table.sort' ).data( 'sortable-link' ),
					data: positions,
					success: function( data ) { 
						$( '#progress' ).hide(); 
					}
				});
			},
			start: function ( event, ui ) {
				// Set correct height for placehoder (from dragged tr)
				ui.placeholder.height( ui.item.height() );

				// Fix placeholder content to make it correct width
				ui.placeholder.html( '<td colspan="' + ( td_count - 1 ) + '"></td><td class="actions"></td>' );
			}
		});
	});
});
