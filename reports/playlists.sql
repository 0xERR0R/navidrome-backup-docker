select p.name     as "PLAYLIST NAME     ",
       mf.artist  as "ARTIST                                ", 
       mf.album   as "ALBUM                                 ", 
       mf.title   as "TITLE                                 "
from playlist_tracks pt
         join playlist p on p.id = pt.playlist_id
         join media_file mf on pt.media_file_id = mf.id
    order by p.name;