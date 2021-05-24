# +--------------------
# |
# | FAST LEAF DECAY
# |
# | Speed up leaf decay
# |
# +----------------------
#
# @author jumpsplat120
# @date 05/23/2021
# @denizen-build 1.2.0-b1739-REL
# @script-version 1.0.1
#
# Installation:
# Place the following scripts in your scripts folder and reload:
#    * fast_leaf_decay.dsc
#
# Usage:
#  Simply break a tree, and normal leaf decay will be much faster.
#
# --------------------END HEADER / START CODE--------------------

fast_leaf_decay:
    type: world
    definitions: loc|mat
    debug: false
    events:
        on leaves decay:
        - determine passively cancelled
        #All nearby leaves touching the one that decayed...
        - define decaying_leaves <context.location.find_blocks[*_leaves].within[10]>
        #Excluding any that are within 6 blocks of a log that they are touching...
        - define decaying_leaves <[decaying_leaves].filter[tree_distance.is_more_than[6]]>
        #Excluding persistent leaves...
        - define decaying_leaves <[decaying_leaves].filter[material.persistent.not]>
        #Excluding ones that have already been flagged, so they don't try to 'decay' twice...
        - define decaying_leaves <[decaying_leaves].filter[has_flag[decaying].not]>
        - foreach <[decaying_leaves]>:
            - flag <[value]> decaying expire:1m
            - run fast_leaf_decay path:remove def:<[value]>|<[value].material.name> delay:<util.random.int[1].to[<[loop_index]>]>t
    remove:
    #If someone were to quickly replace a leaf block with something else, that block won't be deleted.
    - if <[mat]> == <[loc].material.name>:
        - modifyblock <[loc]> air naturally:wooden_hoe
        - flag <[loc]> decaying:!