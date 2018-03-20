program readbyte

    implicit none
    
    character(255)   :: filename,arg_value
    integer*8        :: i,index,n,length,step,j
    real*4           :: real4
    real*8           :: real8
    integer*4        :: int4
    integer*8        :: int8
    character(1)     :: char
    logical          :: file_exists
    
   ! check input
   n = iargc() ! number of arguments
   if (n<2) then
     write(*,'(A)') 'ERROR: Argument(s) missing.'
     write(*,'(A)') 'General use is ./readbyte inputfilename index [number] [step]'
     stop
   end if
   
   ! handle input
   call getarg(1,filename)
   inquire(file=trim(filename),exist=file_exists)
   if (.not.file_exists) then
      write(*,'(A)') 'File does not exist'
      stop
   end if
   call getarg(2,arg_value)
   read(arg_value,*) index
   if (n>=3) then
      call getarg(3,arg_value)
      read(arg_value,*) length
   else
      length = 1
   end if
   if (n>=4) then
      call getarg(4,arg_value)
      read(arg_value,*) step
   else
      step = 1
   end if
   
   ! read data
   i = index
   write(*,'(A)') '1st byte index | Byte |     Int4     |          Int8          '//&
   &'|      Real4      |          Real8          | Char'
   open(1,file=trim(filename),action='read',form='unformatted',access='stream')
   do j = 1,length
      read(1,pos=i) real4
      read(1,pos=i) real8
      read(1,pos=i) int4
      read(1,pos=i) int8
      read(1,pos=i) char
      write(*,'(I14,A,I4,A,I12,A,I22,A,Es15.7,A,Es23.15,A,A3)') &
      & i,' | ',ichar(char),' | ',int4,' | ',int8,' | ',real4,' | ',real8,' | ',char
      i = i+step
   end do
   close(1)
            
end program readbyte