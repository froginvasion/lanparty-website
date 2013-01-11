class TeamsController < ApplicationController
	before_filter :login_required
	# GET /teams
	# GET /teams.json
	def index
		@teams = Team.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @teams }
		end
	end

	# GET /teams/1
	# GET /teams/1.json
	def show
		@team = Team.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @team }
		end
	end

	# GET /teams/new
	# GET /teams/new.json
	def new
		@team = Team.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @team }
		end
	end

	# GET /teams/1/edit
	def edit
		@team = Team.find(params[:id])
	end

	# POST /teams
	# POST /teams.json
	def create
		@team = Team.new(params[:team])

		respond_to do |format|
			if @team.save
				format.html { redirect_to @team, flash:{info: 'Team was successfully created.' }}
				format.json { render json: @team, status: :created, location: @team }
			else
				format.html { render action: "new" }
				format.json { render json: @team.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /teams/1/join
	# PUT /teams/1/join.json
	def join
		@team = Team.find(params[:id])
		@user = current_user
		respond_to do |format|
			if @team.users.include? @user
				flash[:error] = "ermegerd"
				format.html {redirect_to @team, flash:{error: 'Already in team'}}
				format.json { render json: @team.errors, status: :unable_to_join_team }
			elsif @team.users.count >= @team.compo.group_size
				format.html {redirect_to @team, flash:{error: 'team is full'}}
				format.json { render json: @team.errors, status: :unable_to_join_team }
			else
				@team.users << @user
				format.html { redirect_to @team, flash:{info: 'Succesfully joined team.' }}
				format.json { head :no_content }
			end
		end
	end

	# PUT /teams/1/leave
	# PUT /teams/1/leave.json
	def leave
		@team = Team.find(params[:id])
		@user = current_user
		respond_to do |format|
			if @team.users.include? @user
				@team.users.delete @user
				format.html {redirect_to @team, flash:{info: 'Succesfully left team'}}
				format.json {head :no_content}
			else
				format.html {redirect_to @team, flash:{error: 'Not a member of team'}}
				format.json {head :unable_to_leave_team}
			end
		end
	end

	# PUT /teams/1
	# PUT /teams/1.json
	def update
		@team = Team.find(params[:id])

		respond_to do |format|
			if @team.update_attributes(params[:team])
				format.html { redirect_to @team, flash:{info: 'Team was successfully updated.' }}
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @team.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /teams/1
	# DELETE /teams/1.json
	def destroy
		@team = Team.find(params[:id])
		@team.destroy

		respond_to do |format|
			format.html { redirect_to teams_url }
			format.json { head :no_content }
		end
	end
end
