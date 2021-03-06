    /*
     * Some or all of this work - Copyright (c) 2006 - 2019, Intel Corp.
     * All rights reserved.
     *
     * Redistribution and use in source and binary forms, with or without modification,
     * are permitted provided that the following conditions are met:
     *
     * Redistributions of source code must retain the above copyright notice,
     * this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright notice,
     * this list of conditions and the following disclaimer in the documentation
     * and/or other materials provided with the distribution.
     * Neither the name of Intel Corporation nor the names of its contributors
     * may be used to endorse or promote products derived from this software
     * without specific prior written permission.
     *
     * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
     * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
     * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
     * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
     * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
     * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
     * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
     * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
     * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
     * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     */
    /*
     * Bug 185:
     *
     * SUMMARY: In a slack mode Method should implicitly return zero (0) as a default value
     */
    Method (MFC2, 0, Serialized)
    {
        Name (FL00, 0x00)
        Name (I000, 0xABCD0000)
        Name (I001, 0xABCD0001)
        Method (M000, 0, NotSerialized)
        {
            If (FL00)
            {
                Return (0x00)
            }
        }

        Method (M009, 0, NotSerialized)
        {
            Method (M000, 0, NotSerialized)
            {
            }

            If (FL00)
            {
                Return (0x00)
            }

            M000 ()
        }

        /* m000 */

        I000 = 0xDDDD9000
        CH03 (__METHOD__, 0x00, __LINE__, 0x00, 0x00)
        I000 = M000 ()
        If (SLCK)
        {
            CH03 (__METHOD__, 0x00, __LINE__, 0x00, 0x00)
            If ((I000 != 0x00))
            {
                ERR (__METHOD__, ZFFF, __LINE__, 0x00, 0x00, I000, 0x00)
            }
        }
        Else
        {
            CH07 ("", 0x00, 0xFF, 0x00, 0x03, 0x00, 0x00)
        }

        /* m009 */

        I000 = 0xDDDD9000
        CH03 (__METHOD__, 0x00, __LINE__, 0x00, 0x00)
        I000 = M009 ()
        If (SLCK)
        {
            CH03 (__METHOD__, 0x00, __LINE__, 0x00, 0x00)
            If ((I000 != 0x00))
            {
                ERR (__METHOD__, ZFFF, __LINE__, 0x00, 0x00, I000, 0x00)
            }
        }
        Else
        {
            CH07 ("", 0x00, 0xFF, 0x00, 0x07, 0x00, 0x00)
        }
    }
