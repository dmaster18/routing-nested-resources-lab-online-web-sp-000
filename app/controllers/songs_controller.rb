class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @songs = Artist.find_by(id: params[:artist_id]).songs
    else
      @songs = Song.all
      flash[:alert] = "Artist not found."
      redirect_to artists_path
    end
  end

  def show
    @song = Song.find_by(id: params[:id])
    if @song && params[:artist_id]
      @song
    else
      flash[:alert] = "Song not found."
      redirect_to artist_songs_path
    end
  end

  1) SongsController GET index redirects when artist not found
       Failure/Error: @songs = Artist.find(params[:artist_id]).songs

       ActiveRecord::RecordNotFound:
         Couldn't find Artist with 'id'=abc
       # ./app/controllers/songs_controller.rb:4:in `index'


    2) SongsController GET index returns 200 when just index with no artist_id
       Failure/Error: expect(response).to be_ok
         expected `#<ActionDispatch::TestResponse:0x0000000004943e38 @mon_mutex=#<Thread::Mutex:0x0000000004943dc0>, @mo...ch::Http::Headers:0x0000000004941d90 @req=#<ActionController::TestRequest:0x0000000004943fa0 ...>>>>.ok?` to return true, got false


    3) SongsController GET show with  artist returns 200 with valid song and no artist
       Failure/Error: redirect_to artist_songs_path



    4) SongsController GET show with  artist redirects to artists songs when artist song not found
       Failure/Error: @song = Song.find(params[:id])






  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
