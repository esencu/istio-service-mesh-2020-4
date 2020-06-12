based on `Session2/homework`

* added new yaml `course-security.yaml` with mutual tls enabled for peers and integration with Auth0.
* file `request-with-auth-token.sh` could be used get token and access frontend.  
Note: call it in context of you shell to not retrive new token each time, like "`. ./request-with-auth-token.sh`"