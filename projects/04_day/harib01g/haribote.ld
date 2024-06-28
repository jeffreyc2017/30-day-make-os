ENTRY( entry )

SECTIONS
{
  . = 0xc200;
  .text : { *(.text) }
  .data : { *(.data) }
}
