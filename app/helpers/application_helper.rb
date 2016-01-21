module ApplicationHelper
  def currencies_array
  	Currency.all
  end

  def status_array
  	Status.all
  end

  def payment_types
    [['Transference',1], ['Check',2]]
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

  def date_format date
    date.strftime "%m/%d/%Y" if date.present?
  end

  def human_boolean boolean
    boolean ? 'Yes' : 'No'
  end

	def paginate_ajax_js
		"<script>
			$(document).ready(function() {
			$('.pagination a').attr('data-remote', 'true');
		});</script>".html_safe
	end

  def prospect_status_array
  	ProspectStatus.all
  end

  def prospect_types_array
  	ProspectType.all
  end

  def teams_array
  	Team.all
  end

  def estimation_types_array
    EstimationType.all
  end

end