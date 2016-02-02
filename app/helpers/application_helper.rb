module ApplicationHelper

  def payment_types
    [['Transference',1], ['Check',2]]
  end

  def entity_types
    Entity.types.keys.map {|k| [k.humanize, k]}
  end

  def disabled_info form
    "<script type='text/javascript'>
      $().ready(function() {
        $('##{form} :input[type=text]').not('#invoice_expiration_date').attr('disabled', true);
        $('##{form} :input[type=file]').attr('disabled', true);
        $('##{form} select').not('#invoice_status').attr('disabled', true);
        $('##{form} textarea').attr('disabled', true);
        $('##{form} a').attr('hidden', true);
        $('#remove-contact').hide();
        $('#add-contact').hide();
      });</script>".html_safe
  end

	def paginate_ajax_js
		"<script>
			$(document).ready(function() {
			$('.pagination a').attr('data-remote', 'true');
		});</script>".html_safe
	end

end