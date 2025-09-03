for DDD in $(find * -type d -name build); do echo mv -v $DDD ${DDD//build/bin}; done

