err_particle:
    type: data
    debug: false
    wait: 2
    frames:
        - F802
        - F802
        - F802
        - F802
        - F802
        - F803
        - F804
        - F804
        - F804
        - F804
        - F804
        - F805
    colors: <&ns>FF00DC,<&ns>EB00DC,<&ns>D700DC,<&ns>BE00DC,<&ns>A500DC,<&ns>8C00DC,<&ns>7800DC,<&ns>6900DC,<&ns>6900DC,<&ns>7800DC,<&ns>8C00DC,<&ns>A500DC,<&ns>BE00DC,<&ns>D700DC,<&ns>EB00DC,<&ns>FF00DC

# list of players at the end
spawn_particle:
    type: task
    debug: false
    definitions: location|script|colors|amount|offset
    script:
        - define location <[location].if_null[<player.location>]>
        - define script   <[script].if_null[err_particle].as_script.if_null[<script[err_particle]>]>
        - define offset   <[offset].if_null[0,0,0]>
        - define colors   <[colors].if_null[<[script].name.equals[err_particle].if_true[<[script].parsed_key[colors]>].if_false[white]>].split[,].parse_tag[<&color[<[parse_value]>]>]>
        - define players  <queue.definition_map.exclude[raw_context|location|script|colors|amount|offset].values>
        - define players  <list[<player>]> if:<[players].is_empty>
        - define result   <list>
        - repeat <[amount].if_null[1].max[1]>:
            - define pos  <[location].with_y[<[location].y.sub[0.3]>].random_offset[<[offset]>]>
            - fakespawn particle_entity[custom_name=<&chr[F801]><[colors].get[1]><&chr[<[script].data_key[frames].get[1]>]><&chr[F801]>] <[pos]> players:<[players]> d:1y save:particle
            - define result:->:<entry[particle].faked_entity>
            - flag server particles.<[result].last.uuid>:<map.with[frame].as[1].with[colors].as[<map.with[index].as[1].with[data].as[<[colors]>]>].with[pos].as[<[pos]>].with[script].as[<[script]>]>
            - run update_particle def:<[result].last> if:<[script].data_key[wait].is_more_than[0]>
        - determine <[result]>

particle_entity:
    type: entity
    debug: false
    entity_type: armor_stand
    custom_name_visible: true
    marker: true
    visible: false
    invulnerable: true

teleport_particle:
    type: task
    debug: false
    definitions: particle|location
    script:
        - define pos <[location].with_y[<[location].y.sub[0.3]>]>
        - teleport <[particle]> <[pos]>
        - flag server particles.<[particle].uuid>.pos:<[pos]>

remove_particle:
    type: task
    debug: false
    script:
        - if <server.has_flag[particles]>:
            - foreach <queue.definition_map.exclude[raw_context].if_null[<list>]>:
                - define entity <[value].as_entity>
                - define uuid <[entity].uuid>
                - define wait <server.flag[particles.<[uuid]>.script].data_key[wait]>
                - flag server particles.<[uuid]>:!
                - if <[wait]> > 0:
                    - flag <[entity]> remove
                - else:
                    - fakespawn <[entity]> cancel

particle_position:
    type: procedure
    debug: false
    definitions: particle
    script:
        - define pos <server.flag[particles.<[particle].uuid>.pos]>
        - determine <[pos].with_y[<[pos].y.add[0.3]>]>

update_particle:
    type: task
    debug: false
    definitions: particle
    script:
        - while true:
            - define data   <server.flag[particles.<[particle].uuid>]>
            - define colors <[data].deep_get[colors.data]>
            - define frames <[data].get[script].data_key[frames]>
            - define wait   <[data].get[script].data_key[wait]>
            - define frame_index <[data].get[frame].add[1].proc[lib_cycle_value].context[1|<[frames].size>]>
            - define color_index <[data].deep_get[colors.index].add[1].proc[lib_cycle_value].context[1|<[colors].size>]>
            - flag server particles.<[particle].uuid>:<[data].with[frame].as[<[frame_index]>].deep_with[colors.index].as[<[color_index]>]>
            - adjust <[particle]> custom_name:<&chr[F801]><[colors].get[<[color_index]>]><&chr[<[frames].get[<[frame_index]>]>]><&chr[F801]>
            - if <[wait]> > 0:
                - wait <[wait]>t
                - if <[particle].has_flag[remove]>:
                    - fakespawn <[particle]> cancel
                    - while stop
            - else:
                - while stop