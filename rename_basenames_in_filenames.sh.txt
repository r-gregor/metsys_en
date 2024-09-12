nm_staro="HPP_SON_Sturmova-NH"
nm_novo="HPP_SON_Podrozniska-pot-4"

# test
for FJL in *${nm_staro}*; do echo mv -v $FJL ${FJL//${nm_staro}/${nm_novo}}; done

read -p "Continue?"

# action
for FJL in *${nm_staro}*; do mv -v $FJL ${FJL//${nm_staro}/${nm_novo}}; done

