<?hh     /* -*- php -*- */
/**
 * Copyright (c) 2014, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the "hack" directory of this source tree.
 *
 */

class UConverter {
  const REASON_UNASSIGNED = 0;
  const REASON_ILLEGAL = 0;
  const REASON_IRREGULAR = 0;
  const REASON_RESET = 0;
  const REASON_CLOSE = 0;
  const REASON_CLONE = 0;
  const UNSUPPORTED_CONVERTER = 0;
  const SBCS = 0;
  const DBCS = 0;
  const MBCS = 0;
  const LATIN_1 = 0;
  const UTF8 = 0;
  const UTF16_BigEndian = 0;
  const UTF16_LittleEndian = 0;
  const UTF32_BigEndian = 0;
  const UTF32_LittleEndian = 0;
  const EBCDIC_STATEFUL = 0;
  const ISO_2022 = 0;
  const LMBCS_1 = 0;
  const LMBCS_2 = 0;
  const LMBCS_3 = 0;
  const LMBCS_4 = 0;
  const LMBCS_5 = 0;
  const LMBCS_6 = 0;
  const LMBCS_8 = 0;
  const LMBCS_11 = 0;
  const LMBCS_16 = 0;
  const LMBCS_17 = 0;
  const LMBCS_18 = 0;
  const LMBCS_19 = 0;
  const LMBCS_LAST = 0;
  const HZ = 0;
  const SCSU = 0;
  const ISCII = 0;
  const US_ASCII = 0;
  const UTF7 = 0;
  const BOCU1 = 0;
  const UTF16 = 0;
  const UTF32 = 0;
  const CESU8 = 0;
  const IMAP_MAILBOX = 0;

  public function __construct(string $toEncoding = "utf-8", string $fromEncoding = "utf-8");
  public function getSourceEncoding();
  public function setSourceEncoding(string $encoding);
  public function getDestinationEncoding();
  public function setDestinationEncoding(string $encoding);
  public function getSourceType();
  public function getDestinationType();
  public function getSubstChars();
  public function setSubstChars(string $chars);
  public function fromUCallback(int $reason, $source, int $codepoint, inout int $error);
  public function toUCallback(int $reason, $source, $codeunits, inout int $error);
  public function convert(string $str, bool $reverse = false);
  static public function transcode(string $str, string $toEncoding, string $fromEncoding, $options = null);
  public function getErrorCode();
  public function getErrorMessage();
  static public function reasonText(int $reason);
  static public function getAvailable();
  static public function getAliases(string $encoding);
  static public function getStandards();
  static public function getStandardName(string $name, string $standard);
  static public function getMIMEName(string $name);
}
