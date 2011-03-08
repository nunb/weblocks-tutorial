(push #P"/Users/Nandan/programming/cl/tut/" asdf:*central-registry*) 
(ql:quickload "tut")
(ql:quickload "swank")
(swank:create-server :port 5005 :style :spawn :dont-close t)
