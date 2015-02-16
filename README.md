#Taylor Tube
![](https://raw.githubusercontent.com/kchens/kchens.github.io/master/images/taylor-tube-homepage.png)

### Purpose
Taylor Swift is Awesome. Celebrate Taylor Swift with [Taylor Tube](http://taylortube.herokuapp.com).

### Quickstart

1.  `bundle install`
2.  `be shotgun`

As needed, create models & migrations with the `rake` tasks:

```
rake generate:migration  # Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks
rake generate:model      # Create an empty model in app/models, e.g., rake generate:model NAME=User
```

### Contributing

Want to make this site more awesome?

1. Ask for a bug fix or enhancement!
2. Submit a pull request for a bug fix or enhancement!
3. Code review an open pull request!
4. To play with Facebook OAuth, open `index.rb` and `facebook.rb` to change redirect urls from `taylortube.herokuapp.com` to your local host.

### Future Features

1. `Implement pre-caching, long-polling, or WebSockets to update view count
2. Create profile page for "Liked" and "Loved" videos
3. Create a site-wide chat app.
