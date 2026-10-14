SUBROUTINE AUX_CSUB(in, out)
 
 REAL in(7), out(2)
!
! Fortran 90 interface to a C procedure
!
 INTERFACE
  SUBROUTINE TEST_CSUB(in, out)
   !DEC$ ATTRIBUTES C :: TEST_CSUB
   !DEC$ ATTRIBUTES REFERENCE :: in
   !DEC$ ATTRIBUTES REFERENCE :: out
!
! in, out are passed by REFERENCE
!
   REAL in(7), out(2)
  END SUBROUTINE
 END INTERFACE
!
! Call the C procedure
!
 CALL TEST_CSUB(in, out)
 END
