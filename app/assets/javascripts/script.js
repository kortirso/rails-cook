function correction() {
	var thing = $('.up').first().width();
	$('.up').each(function() {
		$(this).css('height', thing);
	});
}

$(function() {
	var nestedForm;
	nestedForm = $('.ingrid').last().clone();
	$('.duplicate').click(function(e) {
		var formsOnPage, lastNestedForm, newNestedForm;
		e.preventDefault();
		lastNestedForm = $('.ingrid').last();
		newNestedForm = $(nestedForm).clone();
		formsOnPage = $('.ingrid').length;
		$(newNestedForm).find('label').each(function() {
			var newLabel, oldLabel;
			oldLabel = $(this).attr('for');
			newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_" + formsOnPage + "_");
			$(this).attr('for', newLabel);
		});
		$(newNestedForm).find('select, input').each(function() {
			var newId, newName, oldId, oldName;
			oldId = $(this).attr('id');
			newId = oldId.replace(new RegExp(/_[0-9]+_/), "_" + formsOnPage + "_");
			$(this).attr('id', newId);
			oldName = $(this).attr('name');
			newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[" + formsOnPage + "]");
			$(this).attr('name', newName);
		});
		$(newNestedForm).insertAfter(lastNestedForm);
	});

	$('#comment_body').keyup(function() {
		if($(this).val().length > 0) {
			$('#add_comment').removeClass('disabled');
		}
		else {
			$('#add_comment').addClass('disabled');
		}
	});

	$('.cat').hover(
		function() {
			$(this).find('.down').fadeIn(500);
		},
		function() {
			$(this).find('.down').fadeOut('fast');
		}
	);

	correction();

	$(window).resize(function() {
		correction();
	});

	$('#recipe_navigator').click(function(e) {
		e.preventDefault();
		if($(this).find('span').hasClass('glyphicon-chevron-down')) {
			$('.panel-body').slideDown(500);
			$(this).find('span').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
			correction();
		}
		else {
			$('.panel-body').slideUp(500);
			$(this).find('span').addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
		}
	});

	$('#star_1').hover(
		function() {
			$('#star_1').attr("src", "/assets/star-fill.png");
		},
		function() {
			$('#star_1').attr("src", "/assets/star-empty.png");
		}
	);

	$('#star_2').hover(
		function() {
			$('#star_1').attr("src", "/assets/star-fill.png");
			$('#star_2').attr("src", "/assets/star-fill.png");
		},
		function() {
			$('#star_1').attr("src", "/assets/star-empty.png");
			$('#star_2').attr("src", "/assets/star-empty.png");
		}
	);

	$('#star_3').hover(
		function() {
			$('#star_1').attr("src", "/assets/star-fill.png");
			$('#star_2').attr("src", "/assets/star-fill.png");
			$('#star_3').attr("src", "/assets/star-fill.png");
		},
		function() {
			$('#star_1').attr("src", "/assets/star-empty.png");
			$('#star_2').attr("src", "/assets/star-empty.png");
			$('#star_3').attr("src", "/assets/star-empty.png");
		}
	);

	$('#star_4').hover(
		function() {
			$('#star_1').attr("src", "/assets/star-fill.png");
			$('#star_2').attr("src", "/assets/star-fill.png");
			$('#star_3').attr("src", "/assets/star-fill.png");
			$('#star_4').attr("src", "/assets/star-fill.png");
		},
		function() {
			$('#star_1').attr("src", "/assets/star-empty.png");
			$('#star_2').attr("src", "/assets/star-empty.png");
			$('#star_3').attr("src", "/assets/star-empty.png");
			$('#star_4').attr("src", "/assets/star-empty.png");
		}
	);

	$('#star_5').hover(
		function() {
			$('#star_1').attr("src", "/assets/star-fill.png");
			$('#star_2').attr("src", "/assets/star-fill.png");
			$('#star_3').attr("src", "/assets/star-fill.png");
			$('#star_4').attr("src", "/assets/star-fill.png");
			$('#star_5').attr("src", "/assets/star-fill.png");
		},
		function() {
			$('#star_1').attr("src", "/assets/star-empty.png");
			$('#star_2').attr("src", "/assets/star-empty.png");
			$('#star_3').attr("src", "/assets/star-empty.png");
			$('#star_4').attr("src", "/assets/star-empty.png");
			$('#star_5').attr("src", "/assets/star-empty.png");
		}
	);
});