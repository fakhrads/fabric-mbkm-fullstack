/*
  SPDX-License-Identifier: Apache-2.0
*/

import {Object, Property} from 'fabric-contract-api';

@Object()
export class Pendaftaran {
    @Property()
    public id: string;

    @Property()
    public mitraId: string;

    @Property()
    public persetujuanId: string;

    @Property()
    public nim: string;

    @Property()
    public nama: string;

    @Property()
    public file: string;

    @Property()
    public program: string;

    @Property()
    public persetujuan: string;

    @Property()
    public selesai_laporan: string;

    @Property()
    public selesai: string;

    @Property()
    public created_at: string;

    @Property()
    public updated_at: string;
}