ENTRY( entry )

SECTIONS
{
  . = 0xc400;
  .text : { *(.text) }
  .data : { *(.data) }
}
