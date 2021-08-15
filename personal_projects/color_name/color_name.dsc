color_name:
    type: task
    definitions: color
    debug: false
    script:
        - ~webget https://encycolorpedia.com/<[color].hex.after[#]> save:result
        - define html <entry[result].result>
        - define name '<[html].after[section id=information<&gt><&lt>h1<&gt>].before[ / ]>'
        - define name '<[html].after[Closely Related<&lt>/h2<&gt>].before[<&lt>br<&gt>].after_last[<&gt>]>' if:<[name].starts_with[#]>
        - determine '<[name].before[ (].to_titlecase>'