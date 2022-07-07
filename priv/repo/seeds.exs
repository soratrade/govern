#     mix run priv/repo/seeds.exs
alias Govern.Repo
alias Govern.Users.User
File.stream!("users.csv")
|> Stream.drop(1)
|> CSV.decode(headers: [:name, :photo, :email, :pass, :pass2])
|> Enum.each(fn {:ok, map} ->
  User.changeset(
    %User{},
    %{name: map[:name], 
    photo: map[:photo], 
    email: map[:email], 
    password: map[:pass], 
    password_confirmation: map[:pass2],
    } 
  )
  |> Repo.insert!()
end)


alias Govern.Feed.Post
File.stream!("posts.csv")
|> Stream.drop(1)
|> CSV.decode(headers: [:content, :user_id])
|> Enum.each(fn {:ok, map} ->
  Post.changeset(
    %Post{},
    %{content: map[:content], user_id: map[:user_id]}    
  )
  |> Repo.insert!()
end)


alias Govern.News.Article
File.stream!("articles.csv")
|> Stream.drop(1)
|> CSV.decode(headers: [:name, :content, :user_id, :photo])
|> Enum.each(fn {:ok, map} ->
  Article.changeset(
    %Article{},
    %{name: map[:name], content: map[:content], user_id: map[:user_id], photo: map[:photo]}
  )
  |> Repo.insert!()
end)


alias Govern.Permits.Permit
File.stream!("permits.csv")
|> Stream.drop(1)
|> CSV.decode(headers: [:name, :photo, :status, :step, :user_id])
|> Enum.each(fn {:ok, map} ->
  Permit.changeset(
    %Permit{},
    %{name: map[:name], photo: map[:photo], step: map[:step], status: map[:status], user_id: map[:user_id]}    
  )
  |> Repo.insert!()
end)


alias Govern.Docs.Document
File.stream!("docs.csv")
|> Stream.drop(1)
|> CSV.decode(headers: [:name, :description, :link, :user_id])
|> Enum.each(fn {:ok, map} ->
  Document.changeset(
    %Document{},
    %{name: map[:name], description: map[:description], link: map[:link], user_id: map[:user_id]}
  )
  |> Repo.insert!()
end)

alias Govern.Pantries.Pantry
File.stream!("pantries.csv")
|> Stream.drop(1)
|> CSV.decode(headers: [:name, :description, :address, :photo, :user_id])
|> Enum.each(fn {:ok, map} ->
  Pantry.changeset(
    %Pantry{},
    %{name: map[:name], description: map[:description], address: map[:address], photo: map[:photo], user_id: map[:user_id]}
  )
  |> Repo.insert!()
end)
