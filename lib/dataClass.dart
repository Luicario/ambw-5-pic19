class cCovidSummaryProvinsi {
  late String cNamaProvinsi;
  late int cConfirmed;
  late int cRecovered;
  late int cDeaths;
  late String cLastUpdate;
  late int cDailyCase;

  cCovidSummaryProvinsi(
      {required this.cNamaProvinsi,
      required this.cConfirmed,
      required this.cRecovered,
      required this.cDeaths,
      required this.cLastUpdate,
      required this.cDailyCase});

  factory cCovidSummaryProvinsi.fromJSON(
      Map<String, dynamic> json, String lastupdate) {
    return cCovidSummaryProvinsi(
        cNamaProvinsi: json['key'],
        cConfirmed: json['jumlah_kasus'],
        cRecovered: json['jumlah_sembuh'],
        cDeaths: json['jumlah_meninggal'],
        cLastUpdate: lastupdate,
        cDailyCase: 0);
  }
}

class cRssFeedsDataView {
  late String cName;
  late String cImage;
  late String cEndPoint;

  cRssFeedsDataView(
      {required this.cName, required this.cImage, required this.cEndPoint});
}

class cInformations {
  late String cName;
  late String cDesc;
  late String cImage;

  cInformations(
      {required this.cName, required this.cDesc, required this.cImage});
}

class cItemRssFeed {
  late String cTitle;
  late String clink;
  late String cPubDate;
  late String cImage;
  cItemRssFeed(
      {required this.cTitle,
      required this.clink,
      required this.cPubDate,
      required this.cImage});
}

class cDataKotaProvinsiVaksin {
  late String cNamaProvinsi;
  late List<String> cKota;
  cDataKotaProvinsiVaksin({required this.cNamaProvinsi, required this.cKota});

  factory cDataKotaProvinsiVaksin.fromJSON(Map<String, dynamic> json) {
    List datakota = json['city'];
    return cDataKotaProvinsiVaksin(
        cNamaProvinsi: json['province'],
        cKota: datakota.map((data) => data.toString()).toList());
  }
}

class cLokasiVaksin {
  late String cNama;
  late String cAlamat;
  late String cDateStart;
  late String cDateEnd;
  late String cTimeStart;
  late String cTimeEnd;
  late bool cIsFree;
  late bool cIsValid;
  late String cRegisMethod;
  late List cVaccAge;
  late String cDesc;
  late String cLink;
  late String map;

  cLokasiVaksin(
      {required this.cNama,
      required this.cAlamat,
      required this.cDateStart,
      required this.cDateEnd,
      required this.cTimeStart,
      required this.cTimeEnd,
      required this.cIsFree,
      required this.cIsValid,
      required this.cRegisMethod,
      required this.cVaccAge,
      required this.cDesc,
      required this.cLink,
      required this.map});

  factory cLokasiVaksin.fromJSON(Map<String, dynamic> json) {
    return cLokasiVaksin(
        cNama: json['title'],
        cAlamat: json['address'],
        cDateStart: json['datestart'],
        cDateEnd: json['dateend'],
        cTimeStart: json['timestart'],
        cTimeEnd: json['timeend'],
        cIsFree: json['isfree'],
        cIsValid: json['isvalid'],
        cRegisMethod: json['registration'],
        cVaccAge: json['agerange'],
        cDesc: json['description'],
        cLink: json['link'],
        map: json['map']);
  }
}

class cDataProvinsi {
  late String cNama;
  late String cId;
  late List<cDataKabKota> ckabkota;

  cDataProvinsi(
      {required this.cNama, required this.cId, required this.ckabkota});

  factory cDataProvinsi.fromJSON(Map<String, dynamic> json) {
    List data = json['data_kabkota'];
    return cDataProvinsi(
        cNama: json['nama_provinsi'],
        cId: json['id_provinsi'],
        ckabkota: data.map((data) => cDataKabKota.fromJSON(data)).toList());
  }
}

class cDataKabKota {
  late String cId;
  late String cNama;

  cDataKabKota({required this.cId, required this.cNama});

  factory cDataKabKota.fromJSON(Map<String, dynamic> json) {
    return cDataKabKota(cId: json['id_kabkota'], cNama: json['nama_kabkota']);
  }
}

class cDataRs {
  late int cId;
  late String cNama;
  late String cAlamat;
  late int cBedIgd;
  late String cHotline;

  cDataRs(
      {required this.cId,
      required this.cNama,
      required this.cAlamat,
      required this.cBedIgd,
      required this.cHotline});

  factory cDataRs.fromJSON(Map<String, dynamic> json) {
    return cDataRs(
        cId: json['id_rs'],
        cNama: json['nama'],
        cAlamat: json['alamat'],
        cBedIgd: json['bed_igd'],
        cHotline: json['hotline']);
  }
}

class cDataKamar {
  late String cNama;
  late String cLastUpdate;
  late cStatus status;

  cDataKamar(
      {required this.cNama, required this.cLastUpdate, required this.status});

  factory cDataKamar.fromJSON(Map<String, dynamic> json) {
    var sts = json['status'];
    var antrian =
        sts['antrian'].toString() == "null" ? "0" : sts['antrian'].toString();

    cStatus cstatus = cStatus(
        cTempatTidur: sts['tempat_tidur'],
        cKosong: sts['kosong'],
        cAntrian: antrian);
    return cDataKamar(
        cNama: json['nama_kamar'],
        cLastUpdate: json['last_update'],
        status: cstatus);
  }
}

class cStatus {
  late String cTempatTidur;
  late String cKosong;
  late String cAntrian;

  cStatus(
      {required this.cTempatTidur,
      required this.cKosong,
      required this.cAntrian});
}
