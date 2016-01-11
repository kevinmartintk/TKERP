function quotation(){

  var array = ["developer", "designer", "account"]
  var total = 0;

  array.forEach(function(entry){

    var calculate_days = function () {
      var hours = $(this).val();
      var days = $(this).closest("tr").find("." + entry + "_days_est");
      var price_per_hour = $(this).closest("tr").find(".estimation_hours_per_day").html();
      var number_days = hours/price_per_hour;
      days.val(number_days);
    }

    $("." + entry + "_hours_est").bind("keyup change", calculate_days);

    var calculate_hours = function () {
      var days = $(this).val();
      var hours = $(this).closest("tr").find("." + entry + "_hours_est");
      var price_per_hour = $(this).closest("tr").find(".estimation_hours_per_day").html();
      var number_hours = days*price_per_hour;
      hours.val(number_hours);
    }

    $("." + entry + "_days_est").bind("keyup change", calculate_hours);

    var calculate_price_hours = function () {
      var hours = $(this).val();
      var price = $(this).closest("tr").find("." + entry + "_price");
      var price_per_hour = $("#quotation_" + entry + "_price_per_hour").val();
      var developers = $(this).closest("tr").find(".developers").html();
      price.val(hours*price_per_hour*developers);

      total = 0;
      // calculate total
      $("." + entry + "_price").each(function () {
        total = parseInt($(this).val()) + total;
      })
      $("#quotation_total").val(total);
    }

    $("." + entry + "_hours_est").bind("keyup change", calculate_price_hours);

    var calculate_price_days = function () {
      var days = $(this).val();
      var hours_per_day = $(this).closest("tr").find(".estimation_hours_per_day").html();
      var developers = $(this).closest("tr").find(".developers").html();
      var hours = days * hours_per_day;
      var price = $(this).closest("tr").find("." + entry + "_price");
      var price_per_hour = $("#quotation_" + entry + "_price_per_hour").val();
      price.val(hours*price_per_hour*developers);

      // calculate total
      $("." + entry + "_price").each(function () {
        total = parseInt($(this).val()) + total;
      })
      $("#quotation_total").val(total);
    }

    $("." + entry + "_days_est").bind("keyup change", calculate_price_days);

    $("#quotation_" + entry + "_price_per_hour").bind("keyup change", function () {
      $("." + entry + "_days_est").each(calculate_price_days);
    });

    $("input[type=checkbox]").change(function() {
      var hours_est = $(this).closest("tr").find("#2_asd ." + entry + "_hours_est");
      var days_est = $(this).closest("tr").find("#2_asd ." + entry + "_days_est");
      if(this.checked) {
        hours_est.prop("readonly",false);
        days_est.prop("readonly",false);
      }
      else{
        hours_est.prop("readonly",true);
        hours_est.val(0).trigger("change");
        days_est.prop("readonly",true);
        days_est.val(0);
      }
    });
  })

  $("input[type=number]").bind("keyup change", function(){
    total = 0
    $(".sub").each(function(){
      total = parseInt($(this).val()) + total;
    })
    $("#quotation_total").val(total);
  });
}
