program os

    implicit none
    character(len=40) :: text
    integer, pointer :: vidmem
    text = "Ur mom"
    vidmem=>loc(753664)
    vidmem = 1
end program os
