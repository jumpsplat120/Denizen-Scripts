global:
    type: data
    chat:
        format: <gray><italic>
        falloff_point: 3
        upper_shouting_limit: 39
        upper_talking_limit: 21

get_intent:
    type: procedure
    definitions: json
    debug: false
    script:
        - define intent_ls <[json].get[intents]>
        - determine <tern[<[intent_ls].is_empty>].pass[false].fail[<[intent_ls].first.get[name]>]>

get_sentence_type:
    type: procedure
    definitions: json
    debug: false
    script:
        - define traits_map <[json].get[traits]>
        - determine <tern[<[traits_map].get[sentence_type]||false>].pass[<[traits_map].get[sentence_type].first.get[value]>].fail[false]>

check_spelling_grammar:
    type: task
    definitions: message
    debug: false
    script:
        - if <[message].length> > 2 && <proc[has_alpha].context[<[message]>]>:
            - define message_ls <[message].split>
            - foreach <[message_ls]>:
                - define alpha <proc[as_alpha].context[<[value]>]>
                - define replacement <script[grammar].data_key[<[alpha]>]||false>
                - define message_ls "<tern[<[replacement].is[==].to[false]>].pass[<[message_ls]>].fail[<[message_ls].set_single[<[value].replace_text[<[alpha]>].with[<[replacement]>]>].at[<[loop_index]>]>]>"
            - define message <[message_ls].space_separated>
            - if <proc[has_valid_ending_puncuation].context[<[message]>].not>:
                - define message <[message]>.
            #Spellcheck fuckin blows lol, maybe we'll find another down the line
            #- ~webget "https://montanaflynn-spellcheck.p.rapidapi.com/check/?text=<[message_ls].space_separated.url_encode>" "headers:<map.with[x-rapidapi-host].as[montanaflynn-spellcheck.p.rapidapi.com].with[x-rapidapi-key].as[b10072555amshd67b2e7f2809fd9p12902fjsn6f3e4bb96c8d].with[useQueryString].as[true]>" save:correction
            #- if <entry[correction].failed>:
            #    - announce "<dark_red>SPELLING CORRECTION HAS FAILED. PLEASE CHECK DEBUG LOG."
            #    - debug error <entry[correction].result>
            #    - stop
            #- define corrections <util.parse_yaml[<entry[correction].result>].get[corrections]>
            #- if <[corrections].size> > 0:
            #    - define incorrects <[corrections].keys>
            #    - foreach <[incorrects]>:
            #        - define message <[message].replace_text[<[value]>].with[<[corrections].get[<[value]>].first>]>
            #- define message <proc[first_letter_uppercase].context[<[message].trim>]><tern[<proc[is_valid_ending_puncuation].context[<[message].char_at[<[message].length>]>]>].pass[].fail[.]>
        - determine <proc[first_letter_uppercase].context[<[message]>]>

get_random_name:
    type: task
    script:
        - ~webget http://names.drycodes.com/5?nameOptions=boy_names save:boy_names
        - ~webget http://names.drycodes.com/5?nameOptions=girl_names save:girl_names
        - define boy_name "<list[<entry[boy_names].result.to_lowercase.trim_to_character_set[abcdefghijklmnopqrstuvwxyz_,].replace_text[,].with[|].replace[_].with[ ]>].random.split>"
        - define girl_name "<list[<entry[girl_names].result.to_lowercase.trim_to_character_set[abcdefghijklmnopqrstuvwxyz_,].replace_text[,].with[|].replace[_].with[ ]>].random.split>"
        - determine "<tern[<util.random.int[1].to[2].is[==].to[1]>].pass[<proc[first_letter_uppercase].context[<[boy_name].first>]> <proc[first_letter_uppercase].context[<[boy_name].last>]>].fail[<proc[first_letter_uppercase].context[<[girl_name].first>]> <proc[first_letter_uppercase].context[<[girl_name].last>]>]>"

get_parsed_nn_result:
    type: task
    definitions: message
    debug: false
    script:
        - ~webget "https://api.wit.ai/message?v=20200811&q=<[message].url_encode>" "headers:<map.with[Authorization].as[{BEARER TOKEN GOES HERE}]>" save:nn_result
        - if <entry[nn_result].failed>:
            - announce "<dark_red>INTENT REQUEST HAS FAILED. PLEASE CHECK DEBUG LOG."
            - debug error <entry[nn_result].result>
            - stop
        - determine <util.parse_yaml[<entry[nn_result].result>]>

local_chat:
    type: task
    definitions: player|message
    debug: false
    script:
        - define config <script[global].data_key[chat]>
        - define upper_limit <tern[<proc[is_uppercase].context[<[message]>]>].pass[<[config].get[upper_shouting_limit]>].fail[<[config].get[upper_talking_limit]>]>
        - define clear <[player].location.find.players.within[<[upper_limit].div[<[config].get[falloff_point]>].round>]>
        - narrate "<&lt><[player].flag[rp_name]><&gt> <[message]>" targets:<[clear]>
        - foreach <[player].location.find.players.within[<[upper_limit]>].exclude[<[clear]>]>:
            - define target <[value]>
            - define list <[message].to_list>
            - define space_list "<[list].find_all[ ]>"
            - define list <[list].remove[<[space_list]>]>
            - repeat <[list].size.sub[<[space_list].size>].mul[<proc[map_range].context[<[upper_limit].div[<[config].get[falloff_point]>]>|<[upper_limit]>|0|1|<[target].location.distance[<player.location>]>]>].round>:
                - define list "<[list].set_single[ ].at[<util.random.int[1].to[<[list].size>]>]>"
            - foreach <[space_list]>:
                - define list "<[list].insert[ ].at[<[value]>]>"
            - narrate "<&lt><[player].flag[rp_name]><&gt> <[list].unseparated>" targets:<[target]>

chatbot:
    type: world
    events:
        on player chats:
            - determine passively cancelled
            - ~run check_spelling_grammar def:<context.message> save:corrected
            - define corrected <entry[corrected].created_queue.determination.first>
            - if !<player.has_flag[rp_name]>:
                - ~run get_random_name save:new_name
                - flag player rp_name:<entry[new_name].created_queue.determination.first>
            - run local_chat def:<player>|<[corrected]>
            - ~run get_parsed_nn_result def:<[corrected]> save:result
            - define result <entry[result].created_queue.determination.first>
            - define intent <proc[get_intent].context[<[result]>]>
            - define s_type <proc[get_sentence_type].context[<[result]>]>
            - narrate "<gray><italic><tern[<[intent].is[==].to[false]>].pass[No intent was detected.].fail[That was a <[intent]>-type <tern[<[s_type].is[==].to[false]>].pass[input].fail[<[s_type]>.]>]>"
