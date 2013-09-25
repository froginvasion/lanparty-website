class ComposController < ApplicationController
	before_action :setup_environment, only: [:show, :edit, :update, :destroy, :save_bracket]
	before_filter :login_required
	before_filter(:except => [:index, :show]) { access_required :compo_editing }

	# GET /compos
	# GET /compos.json
	def index
		@compos = Compo.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @compos }
		end
	end

	# GET /compos/1
	# GET /compos/1.json
	def show
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @compo }
		end
	end

	# GET /compos/new
	# GET /compos/new.json
	def new
		@compo = Compo.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @compo }
		end
	end

	# GET /compos/1/edit
	def edit
	end

	# POST /compos
	# POST /compos.json
	def create
		@compo = Compo.new(compo_params)

		respond_to do |format|
			if @compo.save
				format.html { redirect_to compos_url, flash: { info: 'Compo was successfully created.' } }
				format.json { render json: @compo, status: :created, location: @compo }
			else
				format.html { render action: "new" }
				format.json { render json: @compo.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /compos/1
	# PUT /compos/1.json
	def update
		respond_to do |format|
			if @compo.update(compo_params)
				format.html { redirect_to compos_url, flash: { info: 'Compo was successfully updated.' } }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @compo.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /compos/1
	# DELETE /compos/1.json
	def destroy
		@compo.destroy

		respond_to do |format|
			format.html { redirect_to compos_url }
			format.json { head :no_content }
		end
	end

	def save_bracket
		@bracket_string = params[:compo][:bracket_string]
		@compo.bracket = @bracket_string
		@compo.save
		respond_to do |format|
			format.html {redirect_to @compo, flash: {info:"saved"}}
		end
	end

	private

	def setup_environment
		@compo = Compo.find(params[:id])
	end

	def compo_params
		params.require(:compo).permit(:date_time, :slots, :match_id, :group_size, :game_id, :featured, :description, :bracket, :bbracket_type)
	end
end
