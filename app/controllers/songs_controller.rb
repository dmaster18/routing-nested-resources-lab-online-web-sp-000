class SongsController < ApplicationController
  def index
    if params[:artist_id] != nil
      @songs = Artist.find_by(id: params[:artist_id]).songs
      redirect_to artist_songs_path
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
     Failure/Error: @songs = Artist.find_by(id: params[:artist_id]).songs

     NoMethodError:
       undefined method `songs' for nil:NilClass
     # ./app/controllers/songs_controller.rb:4:in `index'
     # ./spec/controllers/songs_controller_spec.rb:15:in `block (3 levels) in <top (required)>'

  2) SongsController GET index returns 200 when just index with no artist_id
     Failure/Error: expect(response).to be_ok
       expected `#<ActionDispatch::TestResponse:0x0000000004d2a0d8 @mon_mutex=#<Thread::Mutex:0x0000000004d2a060>, @mo...ch::Http::Headers:0x0000000004d36fb8 @req=#<ActionController::TestRequest:0x0000000004d2a268 ...>>>>.ok?` to return true, got false


  3) SongsController GET show with  artist returns 200 with valid song and no artist
     Failure/Error: redirect_to artist_songs_path

     ActionController::UrlGenerationError:
       No route matches {:action=>"index", :controller=>"songs", :id=>"7"} missing required keys: [:artist_id]






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
