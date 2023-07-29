/*
  SPDX-License-Identifier: Apache-2.0
*/

import {Object, Property} from 'fabric-contract-api';

@Object()
export class Registry {
    @Property()
    public id: string;

    @Property()
    public pendaftaranId: string;
    
    @Property()
    public nim: string;

    @Property()
    public nama_kegiatan: string;

    @Property()
    public deskripsi: string;

    @Property()
    public timestamp: string;

}