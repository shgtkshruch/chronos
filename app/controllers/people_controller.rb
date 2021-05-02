class PeopleController < ApplicationController
  def index
    @people = Person.limit(30)
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person
    else
      render :new
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])

    if @person.update(person_params)
      redirect_to @person
    else
      render :edit
    end
  end

  def destroy
    @person = Person.find(params[:id])
    if @person.destroy
      redirect_to people_url
    else
      render :show
    end
  end

  private

  def person_params
    params
      .require(:person)
      .permit(:name, :birthday, :day_of_death, :note)
  end
end
