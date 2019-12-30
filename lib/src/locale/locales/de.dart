// Copyright (c) 2016, rinuk.
// All rights reserved.

// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.

// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
part of tempus;

class LocaleDE implements ILocale {
  @override
  String get seconds => 'einigen Sekunden';

  @override
  String get aMinute => 'einer Minute';
  @override
  String get minutes => '%i Minuten';

  @override
  String get anHour => 'einer Stunde';
  @override
  String get hours => '%i Stunden';

  @override
  String get aDay => 'einem Tag';
  @override
  String get days => '%i Tagen';

  @override
  String get aMonth => 'einem Monat';
  @override
  String get months => '%i Monaten';

  @override
  String get aYear => 'einem Jahr';
  @override
  String get years => '%i Jahren';

  @override
  String get futureIdentifier => 'in';
  @override
  String get pastIdentifier => 'vor';

  @override
  IdentifierPosition get futurePosition => IdentifierPosition.prepend;
  @override
  IdentifierPosition get pastPosition => IdentifierPosition.prepend;

  @override
  List<String> get weekdays => ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'];
}
