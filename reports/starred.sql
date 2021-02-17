select u.user_name         as "USER          ", 
       content.item_type   as "TYPE          ", 
       content.artist      as "ARTIST                                ", 
       content.album       as "ALBUM                                 ", 
       content.title       as "TITLE                                 "
from annotation a
         join user u on u.id = a.user_id
         join (
    select 'media_file' as item_type, id, artist, album, title
    from media_file
    union all
    select 'album' as item_type, id, artist, name as album, '' as title
    from album
) content
        on content.id = a.item_id and content.item_type = a.item_type
where a.starred = 1
order by u.user_name, content.item_type, content.artist, content.album, content.title;