/*
  SPDX-License-Identifier: Apache-2.0
*/

import {Object, Property} from 'fabric-contract-api';

@Object()
export class Registry {
    @Property()
    public docType?: string;

    @Property()
    public ID: string;

    @Property()
    public IDMitra: string;

    @Property()
    public NIM: string;

    @Property()
    public File: string;

    @Property()
    public Program: string;

    @Property()
    public Persetujuan: string;
}