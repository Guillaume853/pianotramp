class PianosController < ApplicationController

   before_action :find_piano, only: [:show, :edit, :update, :destroy, :confirmation_creation]

   def index
     @pianos = Piano.all
     @gmap = "https://maps.googleapis.com/maps/api/js?key=" + ENV["GMAP_KEY"]
   end

  def show
    @gmap = "https://maps.googleapis.com/maps/api/js?key=" + ENV["GMAP_KEY"]
  end

   def new
     @piano= Piano.new
   end

   def create
     @piano = Piano.new(piano_params)
     @piano.user = current_user
     if @piano.save
       redirect_to confirmation_creation_path(id: @piano.id)
     else
       render :new
     end
   end

   def edit
   end

   def update
     if (@piano.user == current_user) && @piano.update(piano_params)
         #attention le update ci-dessus est le update de active record, pas la méthode update du controleur
       redirect_to confirmation_creation_path(id: @piano.id)
     else
       render :edit
     end
   end

   def destroy
     if @piano.user == current_user
       @piano.destroy
       redirect_to pianos_path(user_id: current_user.id)
     else
       flash[:alert] = "You can't delete this product"
     end
   end

   def confirmation_creation
   end

   def research
    if params[:piano]
       @pianos = Piano.select{|piano| (piano.brand.downcase == params[:piano][:brand].downcase)}
     else
       @pianos =[]
     end
   end

   private
   def piano_params
     params.require(:piano).permit(:brand, :address)
   end

   def find_piano
     @piano = Piano.find(params[:id].to_i)
   end
end
