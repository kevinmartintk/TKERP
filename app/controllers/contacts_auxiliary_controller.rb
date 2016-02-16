class ContactsAuxiliaryController < ApplicationController
	def contacts
		Client.find(params[:contact][:contact_id]).contacts
	end	
end
