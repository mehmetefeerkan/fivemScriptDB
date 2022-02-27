// @ts-nocheck

const StoreItemTemplate = (item) => $(`
<div class="item">
	<div class="item-header">
		<div class="item-label">${item.label}</div>
		<div class="item-count">&times; ${item.count}</div>
	</div>
	<img class="item-image" src="${item.src}" />
	<div class="item-footer">
		<div class="item-price">$ ${item.price}</div>
	</div>
</div>
`);

const CartItemTemplate = (item) => $(`
<div class="item">
	<div class="item-header">
		<div class="item-label">${item.label}</div>
		<div class="item-count">&times; ${item.count}</div>
	</div>
	<img class="item-image" src="${item.src}" />
	<div class="item-footer">
		<div class="item-price">$ ${item.price}</div>
		<div class="item-quantity">
			<input class="item-quantity-input" type="text" value="1" />
			<span>&times;</span>
		</div>
	</div>
</div>
`);


$(function () {

	window.addEventListener('message', function (event) {
		if (event.data.type !== 'shop') return;

		$('#store-container').html('').show()
		$('#cart-container').html('').hide()
		
		$('#button-buy').hide();
		$('#button-purchase').hide();
		$('#button-back').hide();
		$('#button-boss').hide();

		$(".item").show();
		$('#store').show();

		event.data.result.forEach(function (itemData) {
			const item = StoreItemTemplate(itemData);
			item.data(itemData);
			item.on('click', function () {
				$('#cart-container').html('');
				item.hide();

				$.post('http://esx-kr-advanced-shops/putcart', JSON.stringify(itemData), function (cartItems) {
					cartItems.forEach((cartItemData) => {
						const cartItem = CartItemTemplate(cartItemData);

						cartItem.find('.item-quantity-input').on('focus', function () {
							if ($(this).val() === "1") {
								$(this).val('')
							}
						}).on('blur', function () {
							if ($(this).val() === '') {
								$(this).val("1")
							}
						})

						cartItem.on('click', function() {
							cartItem.find('.item-quantity-input').focus();
						});

						cartItem.data(cartItemData)
						cartItem.appendTo('#cart-container');
					});

					$('#button-purchase span').html(cartItems.length);
					$('#button-buy span').html(cartItems.length);
					$('#button-purchase').show();
				});
			})

			item.appendTo('#store-container');
		});


		if (event.data.owner === true) {
			$('#button-boss').show();
		} else {
			$('#button-boss').hide();
		}
	});

	$('#button-purchase').on('click', function () {
		$('#cart-container').show();
		$('#store-container').hide();

		$('#button-purchase').hide();
		$('#button-back').show();
		$('#button-buy').show();
	});

	$('#button-back').on('click', function () {
		$('#cart-container').hide();
		$('#store-container').show();

		$('#button-purchase').show();
		$('#button-back').hide();
		$('#button-buy').hide();
	});

	$("#button-boss").on("click", function () {
		$.post('http://esx-kr-advanced-shops/bossactions', JSON.stringify({}));
		$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
		$.post('http://esx-kr-advanced-shops/emptycart', JSON.stringify({}));

		$('#store').hide();
	});

	$("#button-exit").on("click", function () {
		$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
		$.post('http://esx-kr-advanced-shops/emptycart', JSON.stringify({}));

		$('#store').hide();
	});

	$("#button-buy").on("click", function () {
		var items = $('#cart-container .item');

		items.each((i, item) => {
			const quantity = $(item).find('.item-quantity-input').val();
			var isNumber = !isNaN(quantity);
			var count = $(item).data('count');

			if (parseInt(count) >= parseInt(quantity) && parseInt(quantity) != 0 && isNumber) {
				$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
				$.post('http://esx-kr-advanced-shops/buy', JSON.stringify({ count: quantity, item: $(item).data('item') }));
			}
			else {
				$.post('http://esx-kr-advanced-shops/notify', JSON.stringify({ msg: `~r~${$(item).data('label')} ürün stokta yok, market sahibi ile iletisime gec.` }));
			}
		})
		
		$('#store').hide();
	});

	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://esx-kr-advanced-shops/escape', JSON.stringify({}));
			$.post('http://esx-kr-advanced-shops/emptycart', JSON.stringify({}));

			$('#store').hide();
		}
	}
});
