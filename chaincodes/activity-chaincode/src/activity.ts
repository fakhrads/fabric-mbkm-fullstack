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
    public file: string;

    @Property()
    public created_at: string;

    @Property()
    public updated_at: string;

}