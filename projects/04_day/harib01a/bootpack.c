void _io_hlt(void);
void _write_mem8(int addr, int data);

void HariMain(void)
{
	int i; /* �ϐ��錾�Bi�Ƃ����ϐ��́A32�r�b�g�̐����^ */

	for (i = 0xa0000; i <= 0xaffff; i++) {
		_write_mem8(i, 15); /* MOV BYTE [i],15 */
	}

	for (;;) {
		_io_hlt();
	}
}
