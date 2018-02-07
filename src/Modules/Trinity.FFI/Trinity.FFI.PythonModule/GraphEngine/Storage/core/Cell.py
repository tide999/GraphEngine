# -*- coding: utf-8 -*-
"""
Created on Sun Jan 28 20:36:19 2018

@author: yatli/thautwarm
"""

import json
import warnings
from functools import update_wrapper
import GraphEngine as ge
from .SymTable import SymTable, CellType
from .Serialize import Serializer, TSLJSONEncoder

gm: ge.GraphMachine = ge.GraphMachine.inst
if gm is None:
    raise EnvironmentError("GraphMachine wasn't initialized, "
                           "use `ge.GraphMachine(storage_root: str) to start service.`")

_str_concat_format = ' | '.join


class Cell:
    def __init__(self, typ, cell_id=None):
        self._fields = None

        self._cell_id = cell_id

        self._typ: CellType = typ

        self._has_eval = False

        self.dated = False  # is the data needed to be updated

        self.cache_index = None

        self.get = py_cell_getter(self)

        self.set = py_cell_setter(self)

        self.append_field = py_cell_append(self)

    def compute(self):
        if not self.has_eval:
            if self.fields == self.typ.default:
                if self._cell_id is None:
                    self.cache_index = gm.new_cell_by_type(self.typ.name)
                else:
                    self.cache_index = gm.new_cell_by_id_type(self.cell_id, self.typ.name)

                self._update_fields()
            else:
                # default value

                self.cache_index = gm.new_cell_by_type_content(
                    self._typ.name,
                    json.dumps({field: tsl_value
                                for field, tsl_value in self.fields.items()},
                               cls=TSLJSONEncoder))

            self._cell_id = gm.cell_get_id_by_idx(self.cache_index)

            self._has_eval = True

            # TODO: use cache here？
            self.get = computed_cell_getter(self)
            self.set = computed_cell_setter(self)
            self.append_field = computed_cell_append(self)

            return self

    @property
    def fields(self):
        if self._fields is None:
            self._fields = {field_name: field_type.constructor()
                            for field_name, field_type in SymTable.get(self.typ.name).fields.items()}
        elif self._has_eval and self.dated:
            self._update_fields()
            self.dated = False
        return self._fields

    def _update_fields(self):
        """
        this method is for the computed cell.
        :return: None
        """
        self._fields = dict(zip(self.fields.keys(),
                                gm.cell_get_fields(self.cache_index, list(self.fields.keys()))))

    @property
    def cell_id(self):
        if self._cell_id is None and self.has_eval:
            self._cell_id = gm.cell_get_fields(self.cache_index, list(self.fields.keys()))
        return self._cell_id

    @property
    def typ(self):
        return self._typ

    @property
    def has_eval(self):
        return self._has_eval

    def __setitem__(self, key, value):
        warnings.warn(
            "Not recommend to use __setitem__ method because you cannot get whether the setting action succeeds or not."
            "Use .set instead")
        self.set(key, value)

    def __getitem__(self, key):
        return self.get(key)

    def __str__(self):
        type_spec = self.typ.fields

        return "{}{{{}}}".format(self.typ.name,
                                 _str_concat_format(
                                     ["{} : {} = {}".format(k, type_spec[k].sig, v)
                                      for k, v in self.fields.items()]))

    def __repr__(self):
        return self.__str__()


def py_cell_getter(cell: Cell):
    def callback(field):
        value = cell.fields.get(field)

        if value is None:
            warnings.warn("No field named {}".format(field))
            return None

        return value

    return callback


def py_cell_setter(cell: Cell):
    def callback(field, value):
        """
        Return
                 True if succeed in setting field.
                 False if the field does not exist.

        Raise
                 TypeError if type of the value you set is not suitable.
        """
        field_type = cell.typ.fields.get(field)

        if field_type is None:
            warnings.warn("No field named {}".format(field))
            return False

        if not field_type.checker(value):
            raise TypeError("Type `{}` does not match {}.".format(value.__class__.__name__, field_type.sig))

        cell.fields[field] = value
        return True

    return callback


def py_cell_append(cell: Cell):
    def callback(field, content):
        """
        Return
                 True if succeed in setting field.
                 False if the field does not exist.

        Raise
                 TypeError if type of the value you set is not suitable.
        """
        field_type = cell.typ.fields.get(field)
        if field_type is None:
            warnings.warn("No field named {}".format(field))
            return False

        if field_type.constructor is not list:
            raise TypeError("Append method is only for type`List`.")

        if not field_type.checker(content):
            raise TypeError("Type `{}` does not match {}.".format(content.__class__.__name__, field_type.sig))

        cell.fields[field].append(content)
        return True

    return callback


def computed_cell_getter(cell: Cell):
    def callback(field):
        field_type = cell.typ.fields.get(field)

        if field_type is None:
            warnings.warn("No field named {}".format(field))
            return None

        return gm.cell_get_field(cell.cache_index, field)

    return callback


def computed_cell_setter(cell: Cell):
    def callback(field, value):
        """
        Return
                 True if succeed in setting field.
                 False if the field does not exist.

        Raise
                 TypeError if type of the value you set is not suitable.
        """
        field_type = cell.typ.fields.get(field)

        if field_type is None:
            warnings.warn("No field named {}".format(field))
            return False

        if not field_type.checker(value):
            raise TypeError("Type `{}` does not match {}.".format(value.__class__.__name__, field_type.sig))

        gm.cell_set_field(cell.cache_index, field, json.dumps(value, cls=TSLJSONEncoder))

        return True

    return callback


def computed_cell_append(cell: Cell):
    def callback(field, content):
        """
        Return
                 True if succeed in setting field.
                 False if the field does not exist.

        Raise
                 TypeError if type of the value you set is not suitable.
        """
        field_type = cell.typ.fields.get(field)
        if field_type is None:
            warnings.warn("No field named {}".format(field))
            return False

        if field_type.constructor is not list:
            raise TypeError("Append method is only for type`List`.")

        if not field_type.checker(content):
            raise TypeError("Type `{}` does not match {}.".format(content.__class__.__name__, field_type.sig))

        gm.cache_manager.cell_append_field(cell.cache_index, field, json.dumps(content, cls=TSLJSONEncoder))
        return True

    return callback
