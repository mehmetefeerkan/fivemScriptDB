var type = "normal";
var disabled = false;
var disabledFunction = null;

window.addEventListener("message", function (event) {
    if (event.data.action == "setWeight") {
        $(".weight").html(event.data.text);
    } else if (event.data.action == "setWeightSecondary") {
        $(".weightsecondary").html(event.data.text);
    } else if (event.data.action == "display") {
        type = event.data.type
        disabled = false;

        $(".infoplayer-div").html(event.data.text);

		if (type === "normal") {
            $(".info-div").hide();
        } else {
            $(".info-div").show();
        }

        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
        $("#dialog").dialog("close");
        $(".ui").fadeOut();
        $(".item").remove();
        $("#otherInventory").html("<div id=\"noSecondInventoryMessage\"></div>");
        $("#noSecondInventoryMessage").html('');
        $("#weightsecondary").html('');
    } else if (event.data.action == "setItems") {
        inventorySetup(event.data.itemList, event.data.fastItems);

        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function (event, ui) {
                if (disabled) {
                    return false;
                }

                $(this).css('background-image', 'none');
                itemData = $(this).data("item");
                itemInventory = $(this).data("inventory");
            },
            stop: function () {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }
            }
        }).dblclick(function () {
            itemData = $(this).data("item");
            if (itemData.usable) {
                disableInventory(300);
                $('#action-bar').html('');
                $.post("http://m3_inventoryhud/UseItem", JSON.stringify({
                    item: itemData
                }));
            }
        });
    } else if (event.data.action == "setSecondInventoryItems") {
        secondInventorySetup(event.data.itemList);
    } else if (event.data.action == "setShopInventoryItems") {
        shopInventorySetup(event.data.itemList);
    } else if (event.data.action == "setCustomShopInventoryItems") {
        shopCustomInventorySetup(event.data.itemList, event.data.owner);
    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
    } else if (event.data.action == 'itemUsed') {
        ItemUsed(event.data.alerts);
    } else if (event.data.action == "showActionBar") {
        ActionBar(event.data.open,event.data.fastItems);
    } else if (event.data.action == "nearPlayers") {
        $("#nearPlayers").html("");

        $.each(event.data.players, function (index, player) {
            $("#nearPlayers").append('<div class="nearbyPlayerButton" data-player="' + player.player + '">' + player.label + ' (' + player.player + ')</div>');
        });

        $("#dialog").dialog("open");

        $(".nearbyPlayerButton").click(function () {
            $("#dialog").dialog("close");
            player = $(this).data("player");
            $.post("http://m3_inventoryhud/GiveItem", JSON.stringify({
                player: player,
                item: event.data.item,
                number: parseInt($("#count").val())
            }));
        });
    }
});

var alertTimer = null;
var itemimg = null;
var alertcount = 0;

function ItemUsed(alerts) {
    clearTimeout(alertTimer);
    $('#use-alert').fadeOut( 200, function () {
        // $('#use-alert .slotn').remove();
        $.each(alerts, function (index, data) {
            itemimg = 'img/items/' + data.item.itemId + '.png'
            $('#use-alert').append(`<div class="slotn alert-${index}"><div class="itemn"><div class="itemn-count">${data.qty}</div><div class="itemn-name"><img src = ${itemimg} width="100" height="100">${data.item.label}</div></div><div class="alert-text">${data.qty}x ${data.message}</div></div>`)
            if (alertcount === 3) {
                $('#use-alert').fadeOut( 200, function () {
                    $('#use-alert .slotn.expired').remove();
                    $('#use-alert .slotn').addClass('expired');
                    $('#use-alert').html('');
                    alertcount = 0
                });
            }
            alertcount = alertcount + 1
            // console.log(alertcount)
            //     .ready(function () {
            //         $(`.alert-${index}`).find('.itemn').css('background-image', 'url(\'img/items/' + data.item.itemId + '.png\')');
            // });
        });
    });

    $('#use-alert').fadeIn( 200, function () {
        alertTimer = setTimeout(function () {
            $('#use-alert .slotn').addClass('expired');
            alertcount = 0
            $('#use-alert').fadeOut( 200, function () {
                $('#use-alert .slotn.expired').remove();
            });
        }, 1200);
    });
}



// var actionBarTimer = null;

function ActionBar(toggle,items) {
    if (toggle === true) {
        $('#action-bar').html('');
        for (let i = 0; i < 5; i++) {
            if (items[i] != null) {
                $('#action-bar').append(`<div class="slot slot-${i}"><div class="item"><div class="item-count">${items[i].count}</div><div class="item-namet">${items[i].label}</div><div class="item-keybind">${items[i].slot}</div></div></div>`);
                $(`.slot-${i}`).find('.item').css('background-image', 'url(\'img/items/' + items[i].name + '.png\')');
            } else {
                $('#action-bar').append(`<div class="slot slot-${i}" data-empty="true"><div class="item"><div class="item-count"></div><div class="item-namet">Boş</div><div class="item-keybind">${i + 1}</div></div></div>`);
                $(`.slot-${i}`).find('.item').css('background-image', 'none');
            }
        }

        $("#action-bar").fadeIn(150);
    } else if(toggle === false) {
        $("#action-bar").fadeOut(150, function(){
            $("#action-bar").html("");
        });
    }
}

function closeInventory() {
    $('#action-bar').html('');
    $.post("http://m3_inventoryhud/NUIFocusOff", JSON.stringify({}));
}

function inventorySetup(items, fastItems) {
    $("#playerInventory").html("");
    var numberitem = 0;
    $.each(items, function (index, item) {
        count = setCount(item);
        $("#playerInventory").append('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
        $('#playerInventory .slot').on('contextmenu', function (evt) {
            evt.preventDefault();
        numberitem = numberitem +1;
        });
        
        $('#playerInventory .slot').mouseup(function (evt) {
          if (evt.which === 3 && evt.shiftKey) { // right-click + shift
            if (!disabled) {
                item.count = $('#item-' + index).data("item").count;
                transftootherinv(item);
            }
          }
        });
    });

    $("#playerInventoryFastItems").html("");
    var i;
    for (i = 1; i < 6; i++) {
        $("#playerInventoryFastItems").append('<div class="slotFast"><div id="itemFast-'+ i +'" class="item" ><div class="fastKeybind">' + i + '</div><div class="item-count"></div><div class="item-name"></div></div><div class="item-name-bg"></div></div>');
    }
        var i
    for (i = 1; i < (36 - numberitem); i++) {
        $("#playerInventory").append('<div class="slot"><div id="item-' + i + '" class="item" style = "background-image: url(\'img/items/' + "blank" + '.png\')">' +
            '<div class="item-count"></div> <div class="item-name"> </div> </div ><div class="item-name-bg"></div></div>');
    }
    $.each(fastItems, function(index, item) {
        if (item != null) {
            count = setCount(item);
            $('#itemFast-' + item.slot).html('<div class="fastKeybind">'+ item.slot +'</div><div class="item-count">'+ count +'</div><div class="item-name">'+ item.label +'</div>');
            $('#itemFast-' + item.slot).css("background-image", 'url(\'img/items/' + item.name + '.png\')');
            $('#itemFast-' + item.slot).data('item', item);
            $('#itemFast-' + item.slot).data('inventory', "fast");
        }
    });
    makeDraggablesFast()
}

function makeDraggablesFast() {
    $('#itemFast-1').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (itemInventory === "main" || itemInventory === "fast") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 1
                }));
            }
        }
    });
    $('#itemFast-2').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (itemInventory === "main" || itemInventory === "fast") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 2
                }));
            }
        }
    });
    $('#itemFast-3').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (itemInventory === "main" || itemInventory === "fast") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 3
                }));
            }
        }
    });
    $('#itemFast-4').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (itemInventory === "main" || itemInventory === "fast") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 4
                }));
            }
        }
    });
    $('#itemFast-5').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (itemInventory === "main" || itemInventory === "fast") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 5
                }));
            }
        }
    });
}

function secondInventorySetup(items) {
    $("#otherInventory").html("");
    var numberitem = 0;
    $.each(items, function (index, item) {
        count = setCount(item);
        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
        $('#otherInventory .slot').on('contextmenu', function (evt) {
            evt.preventDefault();
        numberitem = numberitem +1;
        });
        
        $('#otherInventory .slot').mouseup(function (evt) {
          if (evt.which === 3 && evt.shiftKey) { // right-click + shift
            if (!disabled) {
                item.count = $('#itemOther-' + index).data("item").count;
                transtoplayerinv(item);
            }
          }
        });
    });
    var i
    for (i = 1; i < (51 - numberitem); i++) {
        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + i + '" class="item" style = "background-image: url(\'img/items/' + "blank" + '.png\')">' +
            '<div class="item-count"></div> <div class="item-name"> </div> </div ><div class="item-name-bg"></div></div>');
    }
}

function shopCustomInventorySetup(items, owner) {
    $("#otherInventory").html("");
    var numberitem = 0;
    $.each(items, function (index, item) {
        cost = setCost(item);
        item.shopowner = owner;

        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + cost + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
        $('#otherInventory .slot').on('contextmenu', function (evt) {
            evt.preventDefault();
        numberitem = numberitem +1;
        });
        
        $('#otherInventory .slot').mouseup(function (evt) {
          if (evt.which === 3 && evt.shiftKey) { // right-click + shift
            if (!disabled) {
                item.count = $('#itemOther-' + index).data("item").count;
                transtoplayerinv(item);
            }
          }
        });
    });
    var i
    for (i = 1; i < (51 - numberitem); i++) {
        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + i + '" class="item" style = "background-image: url(\'img/items/' + "blank" + '.png\')">' +
            '<div class="item-count"></div> <div class="item-name"> </div> </div ><div class="item-name-bg"></div></div>');
    }
}

function shopInventorySetup(items) {
    $("#otherInventory").html("");
    var numberitem = 0;
    $.each(items, function (index, item) {
        cost = setCost(item);

        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + cost + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
        $('#otherInventory .slot').on('contextmenu', function (evt) {
            evt.preventDefault();
        });
        
        $('#otherInventory .slot').mouseup(function (evt) {
          if (evt.which === 3 && evt.shiftKey) { // right-click + shift
            if (!disabled) {
                item.count = $('#itemOther-' + index).data("item").count;
                transtoplayerinv(item);
            }
          }
        });
    });
    var i
    for (i = 1; i < (51 - numberitem); i++) {
        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + i + '" class="item" style = "background-image: url(\'img/items/' + "blank" + '.png\')">' +
            '<div class="item-count"></div> <div class="item-name"> </div> </div ><div class="item-name-bg"></div></div>');
    }
}

function transftootherinv(itemData) {
    if (type === "trunk") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/PutIntoTrunk", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "glovebox") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/PutIntoGlovebox", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "stash") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/PutIntoStash", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "customstash") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/PutIntoCustomStash", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "garbage") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/PutIntoGarbage", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "player") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/PutIntoPlayer", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "drop") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/PutIntoDrop", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    }
}

function transtoplayerinv(itemData) {
    if (type === "trunk") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromTrunk", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "glovebox") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromGlovebox", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "player") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromPlayer", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "stash") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromStash", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "customstash") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromCustomStash", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "garbage") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromGarbage", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "drop") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromDrop", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "shop") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromShop", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    } else if (type === "customshop") {
        disableInventory(300);
        $.post("http://m3_inventoryhud/TakeFromCustomShop", JSON.stringify({
            item: itemData,
            number: parseInt($("#count").val())
        }));
    }
}

function Interval(time) {
    var timer = false;
    this.start = function () {
        if (this.isRunning()) {
            clearInterval(timer);
            timer = false;
        }

        timer = setInterval(function () {
            disabled = false;
            $('.inventory').css('display', 'block');
        }, time);
    };
    this.stop = function () {
        clearInterval(timer);
        timer = false;
    };
    this.isRunning = function () {
        return timer !== false;
    };
}

function disableInventory(ms) {
    disabled = true;
    $('.inventory').css('display', 'none');
    if (disabledFunction === null) {
        disabledFunction = new Interval(ms);
        disabledFunction.start();
    } else {
        if (disabledFunction.isRunning()) {
            disabledFunction.stop(); 
        }

        disabledFunction.start(); 
    }
}

function setCount(item) {
    count = item.count

    // if (item.limit > 0) {
    //     count = item.count + " / " + item.limit
    // }

    if (item.type === 'item_standard' && item.weight != null) {
        count = count + ' (' + item.weight + ')'
    }

    if (item.type === "item_weapon") {
        if (count == 0) {
            count = "";
        } else {
            count = '<img src="img/bullet.png" class="ammoIcon"> ' + item.count;
        }
    }

    if (item.type === "item_account" || item.type === "item_money") {
        count = formatMoney(item.count);
    }

    return count;
}

function setCost(item) {
    cost = item.price

    if (item.price == 0){
        cost = "$" + item.price
    }
    if (item.price > 0) {
        cost = "$" + item.price
    }
    return cost;
}

function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};

$(document).ready(function () {
    $("#count").focus(function () {
        $(this).val("")
    }).blur(function () {
        if ($(this).val() == "" || Number($(this).val()) < 0) {
            $(this).val("0")
        }
    });

    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeInventory();
        }
    });

    $('#use').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined || itemData.usable == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second") {
                return;
            }

            if (itemData.usable) {
                disableInventory(300);
                $.post("http://m3_inventoryhud/UseItem", JSON.stringify({
                    item: itemData
                }));
            }
        }
    });

    $('#give').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second" || itemInventory === "fast") {
                return;
            } else {
            // if (itemData.canRemove || itemData.type === 'item_weapon' || itemData.type === 'item_account' || itemData.type === 'item_money') {
                disableInventory(300);
                $.post("http://m3_inventoryhud/GetNearPlayers", JSON.stringify({
                    item: itemData
                }));
            }
        }
    });
	
    $('#playerInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "glovebox" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "stash" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromStash", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "customstash" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromCustomStash", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "garbage" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromGarbage", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "drop" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromDrop", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "shop" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromShop", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "customshop" && itemInventory === "second") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromCustomShop", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (itemInventory === "fast") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/TakeFromFast", JSON.stringify({
                    item: itemData
                }));
            }
        }
    });

    $('#otherInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "glovebox" && itemInventory === "main") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
			} else if (type === "stash" && itemInventory === "main") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoStash", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "customstash" && itemInventory === "main") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoCustomStash", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "garbage" && itemInventory === "main") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoGarbage", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "drop" && itemInventory === "main") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoDrop", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(300);
                $.post("http://m3_inventoryhud/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });

    $("#count").on("keypress keyup blur", function (event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

$.widget('ui.dialog', $.ui.dialog, {
    options: {
        // Determine if clicking outside the dialog shall close it
        clickOutside: false,
        // Element (id or class) that triggers the dialog opening 
        clickOutsideTrigger: ''
    },
    open: function () {
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function (event) {
                var $target = $(event.target);
                if ($target.closest($(clickOutsideTriggerEl)).length === 0 &&
                    $target.closest($(that.uiDialog)).length === 0) {
                    that.close();
                }
            });
        }
        // Invoke parent open method
        this._super();
    },
    close: function () {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method 
        this._super();
    },
});